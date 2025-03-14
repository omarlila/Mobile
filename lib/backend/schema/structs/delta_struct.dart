// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DeltaStruct extends BaseStruct {
  DeltaStruct({
    String? content,
  }) : _content = content;

  // "content" field.
  String? _content;
  String get content => _content ?? '';
  set content(String? val) => _content = val;

  bool hasContent() => _content != null;

  static DeltaStruct fromMap(Map<String, dynamic> data) => DeltaStruct(
        content: data['content'] as String?,
      );

  static DeltaStruct? maybeFromMap(dynamic data) =>
      data is Map ? DeltaStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'content': _content,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'content': serializeParam(
          _content,
          ParamType.String,
        ),
      }.withoutNulls;

  static DeltaStruct fromSerializableMap(Map<String, dynamic> data) =>
      DeltaStruct(
        content: deserializeParam(
          data['content'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DeltaStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DeltaStruct && content == other.content;
  }

  @override
  int get hashCode => const ListEquality().hash([content]);
}

DeltaStruct createDeltaStruct({
  String? content,
}) =>
    DeltaStruct(
      content: content,
    );
