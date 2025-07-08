import 'dart:convert';

class UserModel {
  final String email, firstName, lastName, avatar;
  final int id;

  UserModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsons) {
    return UserModel(
      email: jsons['email'] ?? 'No email',
      firstName: jsons['first_name'] ?? 'No FirstName',
      lastName: jsons['last_name'] ?? 'No Lastname',
      avatar:
          jsons['avatar'] ??
          'https://images.unsplash.com/photo-1659959104077-d7f31aa44d92',
      id: jsons['id'],
    );
  }
}
