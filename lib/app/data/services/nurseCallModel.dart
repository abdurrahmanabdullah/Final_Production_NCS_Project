//
// class NurseCallingModel {
//   int? id;
//
//   String? remoteId;
//   String? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   NurseCallingModel({
//     this.id,
//     this.remoteId,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   /// Convert a JSON object to an instance of NurseCallingModel
//   factory NurseCallingModel.fromJson(Map<String, dynamic> json) => NurseCallingModel(
//     id: json["id"],
//     remoteId: json["remote_id"],
//     status: json["status"],
//     createdAt: json["created_at"] != null
//         ? DateTime.parse(json["created_at"])
//         : null,
//     updatedAt: json["updated_at"] != null
//         ? DateTime.parse(json["updated_at"])
//         : null,
//   );
//
//   /// Convert an instance of NurseCallingModel to JSON
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "remote_id": remoteId,
//     "status": status,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//   };
// }
///-------------------
// To parse this JSON data, do
//
//     final nurseCallingModel = nurseCallingModelFromJson(jsonString);

import 'dart:convert';

List<NurseCallingModel> nurseCallingModelFromJson(String str) => List<NurseCallingModel>.from(json.decode(str).map((x) => NurseCallingModel.fromJson(x)));

String nurseCallingModelToJson(List<NurseCallingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NurseCallingModel {
  String? remoteId;
  String? name;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  NurseCallingModel({
    this.remoteId,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory NurseCallingModel.fromJson(Map<String, dynamic> json) => NurseCallingModel(
    remoteId: json["remote_id"],
    name: json["name"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "remote_id": remoteId,
    "name": name,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
