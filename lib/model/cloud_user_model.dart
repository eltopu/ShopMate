class CloudUserModel {
  final String documentId;
  String? fullName;
  String? email;
  String? image;

  CloudUserModel({required this.documentId});

  CloudUserModel.fromJson(Map<String, dynamic> json, this.documentId) {
    fullName = json['full_name'];
    email = json['email'];
    image = json['profile_picture'];
  }
}
