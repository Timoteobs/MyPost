import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mypost/app_widget.dart';
import 'package:mypost/modules/home/home_page.dart';
import 'package:mypost/modules/login/login_page.dart';
import 'package:mypost/modules/splash/splash_page.dart';
import 'package:mypost/shared/themes/app_colors.dart';

void main() {
  runApp(AppFirebase());
}

class AppFirebase extends StatefulWidget {
  @override
  State<AppFirebase> createState() => _AppFirebaseState();
}

class _AppFirebaseState extends State<AppFirebase> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Material(
            child: Center(
              child: Text(
                'Oops, Unexpected error! :/',
                textDirection: TextDirection.ltr,
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return AppWidget();
        }
        return const Material(
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
