extension SafeMap<K, V> on Map<K, V>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  //   String toPrettyJson() {
  //   if (this is Map || this is List) {
  //     return const JsonEncoder.withIndent('  ').convert(this);
  //   }

  //   try {
  //     final dynamic object = this;
  //     final jsonMap = object.toJson();
  //     return const JsonEncoder.withIndent('  ').convert(jsonMap);
  //   } catch (e) {
  //     return toString();
  //   }
  // }
}
