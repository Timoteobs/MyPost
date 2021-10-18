import 'package:flutter/material.dart';
import 'package:mypost/modules/home/home_page.dart';
import 'package:mypost/modules/register/regiter_page.dart';
import 'package:mypost/modules/splash/splash_page.dart';
import 'package:mypost/modules/tabs/tabs_page.dart';
import 'package:mypost/shared/themes/app_colors.dart';

import 'modules/login/login_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppColors.primary,
      ),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => const SplashPage(),
        "/home": (context) => const HomePage(),
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage(),
        "/tabs": (context) => const TabsPage(),
      },
    );
  }
}
