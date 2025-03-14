import 'package:collection/collection.dart';

enum Modifier {
  SHORT,
  LONG,
  POLITE,
  FUNNY,
  PROFESSIONAL,
  BETTER_GRAMMAR,
  OTHER,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (Modifier):
      return Modifier.values.deserialize(value) as T?;
    default:
      return null;
  }
}
