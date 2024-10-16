import 'package:health_tracker_app/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map["id"] ?? '',
      email: map["email"] ?? '',
      firstName: map["first_name"] ?? '',
      lastName: map["last_name"] ?? '',
    );
  }

  UserModel copyWith(
      {String? id, String? email, String? firstName, String? lastName}) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}
