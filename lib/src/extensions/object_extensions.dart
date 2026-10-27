// import 'dart:convert';

// extension PrettyPrint on Object {
//   String toPrettyJson() {
//     if (this is Map || this is List) {
//       return const JsonEncoder.withIndent('  ').convert(this);
//     }

//     try {
//       final dynamic object = this;
//       final jsonMap = object.toJson();
//       return const JsonEncoder.withIndent('  ').convert(jsonMap);
//     } catch (e) {
//       return toString();
//     }
//   }
// }
