import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mypost/shared/auth/auth_contoller.dart';
import 'package:mypost/shared/models/register_model.dart';
import 'package:mypost/shared/models/user_model.dart';

class RegisterController {
  final _auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final authController = AuthController();

  CollectionReference usersReference =
      FirebaseFirestore.instance.collection("users");

  Future<void> updateUserName(String name) async {
    await user?.updateDisplayName(name);
  }

  Future<void> registerUser(RegisterModel model, BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: model.email, password: model.password);
      await updateUserName(model.name);

      final userModel = UserModel(
        name: model.name,
        email: model.email,
        emailVerified: userCredential.user?.emailVerified,
      );

      authController.setUser(context, userModel);
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'weak-password') {
        throw 'Essa senha é muito fácil :o';
      } else if (e.code == 'email-already-in-use') {
        throw 'Esse email já existe';
      }
    } catch (e) {
      print(e);
    }
  }
}
