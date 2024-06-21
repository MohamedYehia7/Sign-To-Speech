import 'dart:io';

class CreateAccountModel{
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  File? image;
  CreateAccountModel({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.image
  });
}