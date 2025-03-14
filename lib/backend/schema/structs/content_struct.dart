// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ContentStruct extends BaseStruct {
  ContentStruct({
    String? type,
    String? text,
    ImageUrlStruct? imageUrl,
  })  : _type = type,
        _text = text,
        _imageUrl = imageUrl;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  set text(String? val) => _text = val;

  bool hasText() => _text != null;

  // "image_url" field.
  ImageUrlStruct? _imageUrl;
  ImageUrlStruct get imageUrl => _imageUrl ?? ImageUrlStruct();
  set imageUrl(ImageUrlStruct? val) => _imageUrl = val;

  void updateImageUrl(Function(ImageUrlStruct) updateFn) {
    updateFn(_imageUrl ??= ImageUrlStruct());
  }

  bool hasImageUrl() => _imageUrl != null;

  static ContentStruct fromMap(Map<String, dynamic> data) => ContentStruct(
        type: data['type'] as String?,
        text: data['text'] as String?,
        imageUrl: data['image_url'] is ImageUrlStruct
            ? data['image_url']
            : ImageUrlStruct.maybeFromMap(data['image_url']),
      );

  static ContentStruct? maybeFromMap(dynamic data) =>
      data is Map ? ContentStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'type': _type,
        'text': _text,
        'image_url': _imageUrl?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'text': serializeParam(
          _text,
          ParamType.String,
        ),
        'image_url': serializeParam(
          _imageUrl,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static ContentStruct fromSerializableMap(Map<String, dynamic> data) =>
      ContentStruct(
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        text: deserializeParam(
          data['text'],
          ParamType.String,
          false,
        ),
        imageUrl: deserializeStructParam(
          data['image_url'],
          ParamType.DataStruct,
          false,
          structBuilder: ImageUrlStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ContentStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ContentStruct &&
        type == other.type &&
        text == other.text &&
        imageUrl == other.imageUrl;
  }

  @override
  int get hashCode => const ListEquality().hash([type, text, imageUrl]);
}

ContentStruct createContentStruct({
  String? type,
  String? text,
  ImageUrlStruct? imageUrl,
}) =>
    ContentStruct(
      type: type,
      text: text,
      imageUrl: imageUrl ?? ImageUrlStruct(),
    );
