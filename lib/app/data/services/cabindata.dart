class CabinData {
  final int id;
  final bool msg;

  CabinData({required this.id, required this.msg});

  factory CabinData.fromJson(Map<String, dynamic> json) {
    return CabinData(
      id: json['id'],
      msg: json['attributes']['msg'],
    );
  }
}
// class CabinData {
//   final int id;
//   final bool msg;
//   final bool isAccepted; // New property
//
//   CabinData({
//     required this.id,
//     required this.msg,
//     this.isAccepted = false, // Default to false
//   });
//
//   // Add a copyWith method for immutability
//   CabinData copyWith({
//     int? id,
//     bool? msg,
//     bool? isAccepted,
//   }) {
//     return CabinData(
//       id: id ?? this.id,
//       msg: msg ?? this.msg,
//       isAccepted: isAccepted ?? this.isAccepted,
//     );
//   }
//
//   // Add a factory constructor for JSON deserialization if needed
//   factory CabinData.fromJson(Map<String, dynamic> json) {
//     return CabinData(
//       id: json['id'],
//       msg: json['msg'],
//       isAccepted: json['isAccepted'] ?? false,
//     );
//   }
// }
