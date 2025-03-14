// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MessageStruct extends BaseStruct {
  MessageStruct({
    String? role,
    List<ContentStruct>? content,
    bool? visible,
    String? img,
  })  : _role = role,
        _content = content,
        _visible = visible,
        _img = img;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  set role(String? val) => _role = val;

  bool hasRole() => _role != null;

  // "content" field.
  List<ContentStruct>? _content;
  List<ContentStruct> get content => _content ?? const [];
  set content(List<ContentStruct>? val) => _content = val;

  void updateContent(Function(List<ContentStruct>) updateFn) {
    updateFn(_content ??= []);
  }

  bool hasContent() => _content != null;

  // "visible" field.
  bool? _visible;
  bool get visible => _visible ?? true;
  set visible(bool? val) => _visible = val;

  bool hasVisible() => _visible != null;

  // "img" field.
  String? _img;
  String get img => _img ?? '';
  set img(String? val) => _img = val;

  bool hasImg() => _img != null;

  static MessageStruct fromMap(Map<String, dynamic> data) => MessageStruct(
        role: data['role'] as String?,
        content: getStructList(
          data['content'],
          ContentStruct.fromMap,
        ),
        visible: data['visible'] as bool?,
        img: data['img'] as String?,
      );

  static MessageStruct? maybeFromMap(dynamic data) =>
      data is Map ? MessageStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'role': _role,
        'content': _content?.map((e) => e.toMap()).toList(),
        'visible': _visible,
        'img': _img,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'role': serializeParam(
          _role,
          ParamType.String,
        ),
        'content': serializeParam(
          _content,
          ParamType.DataStruct,
          isList: true,
        ),
        'visible': serializeParam(
          _visible,
          ParamType.bool,
        ),
        'img': serializeParam(
          _img,
          ParamType.String,
        ),
      }.withoutNulls;

  static MessageStruct fromSerializableMap(Map<String, dynamic> data) =>
      MessageStruct(
        role: deserializeParam(
          data['role'],
          ParamType.String,
          false,
        ),
        content: deserializeStructParam<ContentStruct>(
          data['content'],
          ParamType.DataStruct,
          true,
          structBuilder: ContentStruct.fromSerializableMap,
        ),
        visible: deserializeParam(
          data['visible'],
          ParamType.bool,
          false,
        ),
        img: deserializeParam(
          data['img'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'MessageStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is MessageStruct &&
        role == other.role &&
        listEquality.equals(content, other.content) &&
        visible == other.visible &&
        img == other.img;
  }

  @override
  int get hashCode => const ListEquality().hash([role, content, visible, img]);
}

MessageStruct createMessageStruct({
  String? role,
  bool? visible,
  String? img,
}) =>
    MessageStruct(
      role: role,
      visible: visible,
      img: img,
    );
