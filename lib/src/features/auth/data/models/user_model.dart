import 'package:flutter_take_home/src/features/auth/domain/entities/user.dart';

class UserModel {
  final String id;
  final String name;

  UserModel({
    required this.id,
    required this.name
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name']
    );
  }

  User toEntity() {
    return User(
      id: id,
      username: name
    );
  }
}