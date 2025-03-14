// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ImageUrlStruct extends BaseStruct {
  ImageUrlStruct({
    String? url,
  }) : _url = url;

  // "url" field.
  String? _url;
  String get url => _url ?? '';
  set url(String? val) => _url = val;

  bool hasUrl() => _url != null;

  static ImageUrlStruct fromMap(Map<String, dynamic> data) => ImageUrlStruct(
        url: data['url'] as String?,
      );

  static ImageUrlStruct? maybeFromMap(dynamic data) =>
      data is Map ? ImageUrlStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'url': _url,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'url': serializeParam(
          _url,
          ParamType.String,
        ),
      }.withoutNulls;

  static ImageUrlStruct fromSerializableMap(Map<String, dynamic> data) =>
      ImageUrlStruct(
        url: deserializeParam(
          data['url'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ImageUrlStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ImageUrlStruct && url == other.url;
  }

  @override
  int get hashCode => const ListEquality().hash([url]);
}

ImageUrlStruct createImageUrlStruct({
  String? url,
}) =>
    ImageUrlStruct(
      url: url,
    );
