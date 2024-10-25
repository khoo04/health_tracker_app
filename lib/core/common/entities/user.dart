class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final int? weight;
  final int? height;
  final int? age;
  final String? sex;
  final double? bmi;
  final String? dailyBasis;
  final double? walkingSpeed;
  final int? targetStep;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.weight,
    this.height,
    this.age,
    this.sex,
    this.bmi,
    this.dailyBasis,
    this.walkingSpeed,
    this.targetStep,
  });
}
