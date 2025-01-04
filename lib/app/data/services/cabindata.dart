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
