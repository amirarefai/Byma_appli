import 'dart:io';

class CustomerRegisterModel {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phone;
  final File profileImage;
  final File idImage;

  CustomerRegisterModel({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.profileImage,
    required this.idImage,
  });
}