import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mypost/modules/register/register_controller.dart';
import 'package:mypost/shared/auth/auth_contoller.dart';
import 'package:mypost/shared/models/login_model.dart';
import 'package:mypost/shared/models/user_model.dart';

class LoginController {
  final authController = AuthController();
  final _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

  Future<void> googleSignIn(BuildContext context) async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    try {
      final response = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await response?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      final user = UserModel(
        name: response!.displayName!,
        photoURL: response.photoUrl,
        email: response.email,
      );

      authController.setUser(context, user);
    } catch (error) {
      authController.setUser(context, null);
    }
  }

  Future<void> signIn(LoginModel model, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: model.email, password: model.password);
      print(userCredential.user);

      final userModel = UserModel(
          name: userCredential.user!.displayName!,
          email: userCredential.user!.email!);

      authController.setUser(context, userModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
