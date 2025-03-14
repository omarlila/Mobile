import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

List<ContentStruct> buildContent(
  String? text,
  String? imageUrl,
) {
  if (text == null && imageUrl == null) {
    return [ContentStruct(type: "text", text: "")];
  }

  List<ContentStruct> contents = [];
  if (text != null) {
    contents.add(ContentStruct(type: "text", text: text));
  }
  if (imageUrl != null) {
    contents.add(ContentStruct(
        type: "image_url", imageUrl: ImageUrlStruct(url: imageUrl)));
  }

  return contents;
}

int? mapCharactersCount(int charCount) {
  // Used to ensure messages are never hidden behind TextInput

  if (charCount >= 209) {
    return 175;
  } else if (charCount <= 35) {
    return 82;
  } else {
    // Linear interpolation between the two points (35, 82) and (209, 175)
    double slope = (175 - 82) / (209 - 35);
    return (82 + slope * (charCount - 35)).round();
  }
}

dynamic parsePartialJson(String input) {
  // Clean up the input
  input = input.replaceAll(RegExp(r',\s*(?=[}\]])'), '');

  // Ensure the input starts with a brace or bracket
  if (!input.trimLeft().startsWith('{') && !input.trimLeft().startsWith('[')) {
    input = '{' + input;
  }

  // Balance the JSON structure
  List<String> stack = [];
  bool inString = false;
  StringBuffer buffer = StringBuffer();

  for (int i = 0; i < input.length; i++) {
    var char = input[i];

    if (char == '"' && (i == 0 || input[i - 1] != '\\')) {
      inString = !inString;
    }

    if (!inString) {
      if (char == '{' || char == '[') {
        stack.add(char);
      } else if (char == '}' && stack.isNotEmpty && stack.last == '{') {
        stack.removeLast();
      } else if (char == ']' && stack.isNotEmpty && stack.last == '[') {
        stack.removeLast();
      }
    }

    buffer.write(char);
  }

  // Close any unclosed strings
  if (inString) buffer.write('"');

  // Remove incomplete key-value pairs
  String bufferStr = buffer.toString();
  int lastColon = bufferStr.lastIndexOf(':');
  int lastComma = bufferStr.lastIndexOf(',');
  if (lastColon > lastComma) {
    bufferStr = bufferStr.substring(0, lastComma != -1 ? lastComma : lastColon);
  }

  // Close incomplete JSON structures
  while (stack.isNotEmpty) {
    if (stack.last == '{') {
      if (bufferStr.trim().endsWith('{') ||
          bufferStr.trim().endsWith(':') ||
          bufferStr.trim().endsWith(',')) {
        bufferStr += '"incomplete": null';
      }
      bufferStr += '}';
    } else if (stack.last == '[') {
      if (bufferStr.trim().endsWith('[') || bufferStr.trim().endsWith(',')) {
        bufferStr += 'null';
      }
      bufferStr += ']';
    }
    stack.removeLast();
  }

  // Attempt to parse the completed JSON
  try {
    return json.decode(bufferStr);
  } catch (e) {
    // If parsing fails, try partial parsing
    if (bufferStr.startsWith('{')) {
      return parsePartialObject(bufferStr);
    } else if (bufferStr.startsWith('[')) {
      return parsePartialArray(bufferStr);
    }
    return null;
  }
}

dynamic parseValue(String value) {
  if (value.startsWith('{') && value.endsWith('}')) {
    return parsePartialObject(value);
  } else if (value.startsWith('[') && value.endsWith(']')) {
    return parsePartialArray(value);
  } else if (value.startsWith('"') && value.endsWith('"')) {
    return value.substring(1, value.length - 1);
  } else if (value == 'true') {
    return true;
  } else if (value == 'false') {
    return false;
  } else if (value == 'null') {
    return null;
  } else {
    return num.tryParse(value) ?? value;
  }
}

dynamic parsePartialObject(String input) {
  Map<String, dynamic> result = {};
  RegExp keyValuePairRegex = RegExp(r'"([^"]+)"\s*:\s*([^,}]+)');
  var matches = keyValuePairRegex.allMatches(input);

  for (var match in matches) {
    String key = match.group(1)!;
    String value = match.group(2)!.trim();
    result[key] = parseValue(value);
  }

  return result;
}

List<dynamic> parsePartialArray(String input) {
  List<dynamic> result = [];
  RegExp elementRegex = RegExp(r'(?:[^,\[\]{}]+|\{[^{}]*\}|\[[^\[\]]*\])');
  var matches = elementRegex.allMatches(input);

  for (var match in matches) {
    String value = match.group(0)!.trim();
    result.add(parseValue(value));
  }

  return result;
}

String sanitizeMarkdown(String input) {
  // Remove markdown bullet points
  input = input.replaceAll(RegExp(r'^\s*[-*]\s+', multiLine: true), '');

  // Remove code blocks (assuming they're wrapped in triple backticks)
  input = input.replaceAll(RegExp(r'```.*?```', dotAll: true), '');

  // Handle other markdown features as needed
  return input;
}

dynamic formatMessages(List<MessageStruct> messages) {
  return messages.map((message) {
    final map = message.toMap();
    map.remove('visible'); // Remove the "visible" key from the map
    return map;
  }).toList();
}

dynamic contentToJson(List<ContentStruct> content) {
  return content.map((contentItem) => contentItem.toSerializableMap()).toList();
}

dynamic extractDataFromContent(ContentStruct content) {
  // Check if the text is not null or empty
  if (content.hasText()) {
    // Parse the JSON string in the text field
    final Map<String, dynamic> parsedJson = jsonDecode(content.text);

    // Extract the "data" field
    if (parsedJson.containsKey('data')) {
      return parsedJson['data'];
    } else {
      throw Exception('Data field not found in content.');
    }
  } else {
    throw Exception('Content text is null or empty.');
  }
}

String? extractTypeFromAssistantMessage(String jsonStr) {
  print("Extracting type: ");
  print(jsonStr);
  print("Type is: ${jsonDecode(jsonStr)['type']}");
  return jsonDecode(jsonStr)['type'];
}

String printUploadedFile(FFUploadedFile file) {
  return file.toString();
}

List<String>? extractImgs(List<String> jsonStrings) {
  return jsonStrings.map((str) => jsonDecode(str)['url'] as String).toList();
}

dynamic saveChatHistory(
  dynamic chatHistory,
  dynamic newChat,
) {
  // If chatHistory isn't a list, make it a list and then add newChat
  if (chatHistory is List) {
    chatHistory.add(newChat);
    return chatHistory;
  } else {
    return [newChat];
  }
}

dynamic convertToJSON(String prompt) {
  // take the prompt and return a JSON with form [{"role": "user", "content": prompt}]
  return json.decode('{"role": "user", "content": "$prompt"}');
}
