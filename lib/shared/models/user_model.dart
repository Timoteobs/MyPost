import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String? photoURL;
  final bool? emailVerified;

  UserModel({
    required this.name,
    this.photoURL,
    required this.email,
    this.emailVerified,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'],
        email: map['email'],
        photoURL: map['photoURL'],
        emailVerified: map["emailVerified"]);
  }

  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() => {
        "name": name,
        "photoURL": photoURL,
        "email": email,
        "eemailVerified": emailVerified,
      };

  String toJson() => jsonEncode(toMap());
}
