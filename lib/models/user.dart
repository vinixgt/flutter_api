import 'package:flutter_api_rest/api/my_api.dart';
import 'package:meta/meta.dart';

class User {
  final String id;
  final String userName;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String avatar;

  User({
    @required this.id,
    @required this.userName,
    @required this.email,
    @required this.createdAt,
    @required this.updatedAt,
    this.avatar
  });

  setAvatar(String url) {
    return User(
      id: this.id,
      email: this.email,
      userName: this.userName,
      createdAt: this.createdAt,
      updatedAt: this.updatedAt,
      avatar: url
    );
  }

  static User fromJson(Map<String, dynamic> json) {
    String avatar;
    if(json['avatar'] != null) {
      avatar = baseUrl + json['avatar'];
    }
    return User(
      id: json['_id'],
      userName: json['username'],
      email: json['email'],
      avatar: avatar,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}