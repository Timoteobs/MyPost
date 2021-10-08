import 'package:flutter/material.dart';
import 'package:mypost/modules/login/login_page.dart';
import 'package:mypost/modules/splash/splash_page.dart';
import 'package:mypost/shared/themes/app_colors.dart';

void main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppColors.primary,
      ),
      home: LoginPage(),
    );
  }
}
