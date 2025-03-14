import '../database.dart';

class ChatTable extends SupabaseTable<ChatRow> {
  @override
  String get tableName => 'chat';

  @override
  ChatRow createRow(Map<String, dynamic> data) => ChatRow(data);
}

class ChatRow extends SupabaseDataRow {
  ChatRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ChatTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int get chatInfo => getField<int>('chat - info')!;
  set chatInfo(int value) => setField<int>('chat - info', value);

  int? get chatNumbers => getField<int>('chat numbers');
  set chatNumbers(int? value) => setField<int>('chat numbers', value);
}
