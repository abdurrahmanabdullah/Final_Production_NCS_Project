// // To parse this JSON data, do
// //
// //     final audioListModel = audioListModelFromJson(jsonString);
//
// import 'dart:convert';
//
// List<NurseCallingModel> audioListModelFromJson(String str) => List<NurseCallingModel>.from(json.decode(str).map((x) => NurseCallingModel.fromJson(x)));
//
// String audioListModelToJson(List<NurseCallingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class NurseCallingModel {
//   int? id;
//   String? remoteId;
//   String? status;
//   dynamic createdAt;
//   dynamic updatedAt;
//
//   NurseCallingModel({
//     this.id,
//     this.remoteId,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });
// /// convert toJson() Method. create an instance of NurseCallingModel from a JSON object
//   factory NurseCallingModel.fromJson(Map<String, dynamic> json) => NurseCallingModel(
//     id: json["id"],
//     remoteId: json["remote_id"],
//     status: json["status"],
//     createdAt: json["created_at"],
//     updatedAt: json["updated_at"],
//   );
//   ///Sending data to APIs:
//   //It converts the properties of the NurseCallingModel object into a Map<String, dynamic>.
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "remote_id": remoteId,
//     "status": status,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//   };
// }
class NurseCallingModel {
  int? id;
  String? remoteId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  NurseCallingModel({
    this.id,
    this.remoteId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  /// Convert a JSON object to an instance of NurseCallingModel
  factory NurseCallingModel.fromJson(Map<String, dynamic> json) => NurseCallingModel(
    id: json["id"],
    remoteId: json["remote_id"],
    status: json["status"],
    createdAt: json["created_at"] != null
        ? DateTime.parse(json["created_at"])
        : null,
    updatedAt: json["updated_at"] != null
        ? DateTime.parse(json["updated_at"])
        : null,
  );

  /// Convert an instance of NurseCallingModel to JSON
  Map<String, dynamic> toJson() => {
    "id": id,
    "remote_id": remoteId,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
