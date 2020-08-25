import 'package:meta/meta.dart';

class User {
  final String id;
  final String userName;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    @required this.id,
    @required this.userName,
    @required this.email,
    @required this.createdAt,
    @required this.updatedAt
  });

  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      userName: json['username'],
      email: json['email'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}