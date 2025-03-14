// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<FFUploadedFile> renameAudio(
    FFUploadedFile audio, String audioPath) async {
  // Add your function code here!

  // This is sort of a seemingly unncessary thing to need to do, but there is currently a bug in FlutterFlow,
  // which was reported here: https://github.com/FlutterFlow/flutterflow-issues/issues/2751 and
  // the team is aware and actively searching for a way to fix! The gist is that we assume file
  // type to be mp3 when we stop the audio recording. This works for some devices that have recorded
  // and saved the file as an mp3. But on any other devices, like an iPhone for example, the
  // recorded file is not guaranteed to be in mp3 format.
  //
  // So this function takes in the recorded file path to determine the correct format for the name
  // of the FFUploadedFile by using regex to get the file extension and then composing a name based
  // off of that for the FFUploadedFile.
  //
  // In the future, once the issue is fixed, this action won't be necessary.

  RegExp regExp = RegExp(r'\.([a-zA-Z0-9]+)$');
  Match? match = regExp.firstMatch(audioPath);

  return FFUploadedFile(
    name: "recordedFileBytes.${match!.group(1)}",
    bytes: audio.bytes,
  );
}
