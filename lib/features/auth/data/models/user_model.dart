import 'package:health_tracker_app/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.firstName,
    required super.lastName,
    super.age,
    super.bmi,
    super.dailyBasis,
    super.height,
    super.weight,
    super.sex,
    super.targetStep,
    super.walkingSpeed,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map["user_id"] ?? '',
      email: map["email"] ?? '',
      firstName: map["first_name"] ?? '',
      lastName: map["last_name"] ?? '',
      weight: map["weight"],
      height: map["height"],
      age: map["age"],
      sex: map["sex"],
      bmi: map["bmi"],
      dailyBasis: map["daily_basis"],
      walkingSpeed: map["walking_speed"],
      targetStep: map["target_step"],
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    int? age,
    int? weight,
    int? height,
    String? sex,
    double? bmi,
    String? dailyBasis,
    double? walkingSpeed,
    int? targetStep,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      sex: sex ?? this.sex,
      bmi: bmi ?? this.bmi,
      dailyBasis: dailyBasis ?? this.dailyBasis,
      walkingSpeed: walkingSpeed ?? this.walkingSpeed,
      targetStep: targetStep ?? this.targetStep,
    );
  }

  @override
  String toString() {
    return 'User('
        'id: $id, '
        'email: $email, '
        'firstName: $firstName, '
        'lastName: $lastName, '
        'weight: $weight, '
        'height: $height, '
        'age: $age, '
        'sex: $sex, '
        'bmi: $bmi, '
        'dailyBasis: $dailyBasis, '
        'walkingSpeed: $walkingSpeed, '
        'targetStep: $targetStep'
        ')';
  }
}
