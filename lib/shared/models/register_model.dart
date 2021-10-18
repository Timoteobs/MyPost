import 'package:flutter/material.dart';
import "dart:io";

class RegisterModel {
  String name;
  String email;
  File? image;
  String password;

  RegisterModel({
    required this.name,
    required this.email,
    this.image,
    required this.password,
  });
}
