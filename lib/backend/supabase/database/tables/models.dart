import '../database.dart';

class ModelsTable extends SupabaseTable<ModelsRow> {
  @override
  String get tableName => 'models';

  @override
  ModelsRow createRow(Map<String, dynamic> data) => ModelsRow(data);
}

class ModelsRow extends SupabaseDataRow {
  ModelsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ModelsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  String get version => getField<String>('version')!;
  set version(String value) => setField<String>('version', value);

  String? get quantization => getField<String>('quantization');
  set quantization(String? value) => setField<String>('quantization', value);

  int? get contextLength => getField<int>('context_length');
  set contextLength(int? value) => setField<int>('context_length', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  bool? get isActive => getField<bool>('is_active');
  set isActive(bool? value) => setField<bool>('is_active', value);

  dynamic get config => getField<dynamic>('config');
  set config(dynamic value) => setField<dynamic>('config', value);
}
