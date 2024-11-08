import 'package:flutter_take_home/src/features/auth/domain/entities/user.dart';

class UserModel {
  final String id;
  final String name;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email']
    );
  }

  User toEntity() {
    return User(
      id: id,
      username: name,
      email: email
    );
  }
}