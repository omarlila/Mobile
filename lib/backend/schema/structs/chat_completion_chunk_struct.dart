// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ChatCompletionChunkStruct extends BaseStruct {
  ChatCompletionChunkStruct({
    String? id,
    String? object,
    int? created,
    String? model,
    String? systemFingerprint,
    List<ChoicesStruct>? choices,
  })  : _id = id,
        _object = object,
        _created = created,
        _model = model,
        _systemFingerprint = systemFingerprint,
        _choices = choices;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "object" field.
  String? _object;
  String get object => _object ?? '';
  set object(String? val) => _object = val;

  bool hasObject() => _object != null;

  // "created" field.
  int? _created;
  int get created => _created ?? 0;
  set created(int? val) => _created = val;

  void incrementCreated(int amount) => created = created + amount;

  bool hasCreated() => _created != null;

  // "model" field.
  String? _model;
  String get model => _model ?? '';
  set model(String? val) => _model = val;

  bool hasModel() => _model != null;

  // "system_fingerprint" field.
  String? _systemFingerprint;
  String get systemFingerprint => _systemFingerprint ?? '';
  set systemFingerprint(String? val) => _systemFingerprint = val;

  bool hasSystemFingerprint() => _systemFingerprint != null;

  // "choices" field.
  List<ChoicesStruct>? _choices;
  List<ChoicesStruct> get choices => _choices ?? const [];
  set choices(List<ChoicesStruct>? val) => _choices = val;

  void updateChoices(Function(List<ChoicesStruct>) updateFn) {
    updateFn(_choices ??= []);
  }

  bool hasChoices() => _choices != null;

  static ChatCompletionChunkStruct fromMap(Map<String, dynamic> data) =>
      ChatCompletionChunkStruct(
        id: data['id'] as String?,
        object: data['object'] as String?,
        created: castToType<int>(data['created']),
        model: data['model'] as String?,
        systemFingerprint: data['system_fingerprint'] as String?,
        choices: getStructList(
          data['choices'],
          ChoicesStruct.fromMap,
        ),
      );

  static ChatCompletionChunkStruct? maybeFromMap(dynamic data) => data is Map
      ? ChatCompletionChunkStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'object': _object,
        'created': _created,
        'model': _model,
        'system_fingerprint': _systemFingerprint,
        'choices': _choices?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'object': serializeParam(
          _object,
          ParamType.String,
        ),
        'created': serializeParam(
          _created,
          ParamType.int,
        ),
        'model': serializeParam(
          _model,
          ParamType.String,
        ),
        'system_fingerprint': serializeParam(
          _systemFingerprint,
          ParamType.String,
        ),
        'choices': serializeParam(
          _choices,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static ChatCompletionChunkStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ChatCompletionChunkStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        object: deserializeParam(
          data['object'],
          ParamType.String,
          false,
        ),
        created: deserializeParam(
          data['created'],
          ParamType.int,
          false,
        ),
        model: deserializeParam(
          data['model'],
          ParamType.String,
          false,
        ),
        systemFingerprint: deserializeParam(
          data['system_fingerprint'],
          ParamType.String,
          false,
        ),
        choices: deserializeStructParam<ChoicesStruct>(
          data['choices'],
          ParamType.DataStruct,
          true,
          structBuilder: ChoicesStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ChatCompletionChunkStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ChatCompletionChunkStruct &&
        id == other.id &&
        object == other.object &&
        created == other.created &&
        model == other.model &&
        systemFingerprint == other.systemFingerprint &&
        listEquality.equals(choices, other.choices);
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, object, created, model, systemFingerprint, choices]);
}

ChatCompletionChunkStruct createChatCompletionChunkStruct({
  String? id,
  String? object,
  int? created,
  String? model,
  String? systemFingerprint,
}) =>
    ChatCompletionChunkStruct(
      id: id,
      object: object,
      created: created,
      model: model,
      systemFingerprint: systemFingerprint,
    );
