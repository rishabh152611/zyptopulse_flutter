class UserModel {
  final String id;
  final String email;
  final String firstName;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      email: json['email'],
      firstName: json['first_name'],
    );
  }
}
