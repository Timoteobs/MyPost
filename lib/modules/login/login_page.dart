import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mypost/modules/login/login_controller.dart';
import 'package:mypost/shared/button/custom_button.dart';
import 'package:mypost/shared/custominput/custom_input_box.dart';
import 'package:mypost/shared/models/login_model.dart';
import 'package:mypost/shared/models/user_model.dart';
import 'package:mypost/shared/social_login/social_login_button.dart';
import 'package:mypost/shared/themes/app_colors.dart';
import 'package:mypost/shared/themes/app_image.dart';
import 'package:mypost/shared/themes/app_text_styles.dart';
import 'package:mypost/shared/themes/app_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  login() {
    if (_form.currentState!.validate()) {
      final model = LoginModel(email: _email.text, password: _password.text);
      controller.signIn(model, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40, top: 40),
                    child: Text(
                      "Entrar",
                      style: TextStyles.titleHome,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, top: 40),
                    child: SocialLoginButton(
                      onTap: () {
                        controller.googleSignIn(context);
                      },
                    ),
                  ),
                ),
                Form(
                  key: _form,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      MyCustomInputBox(
                        label: "Email",
                        hint: 'exemplo@gmail.com',
                        controller: _email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Informe o Email";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyCustomInputBox(
                        label: "Senha",
                        hint: 'Mínimo 6 caracteres',
                        controller: _password,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 24),
                    child: ElevatedButton(
                      onPressed: login,
                      style:
                          ElevatedButton.styleFrom(primary: AppColors.primary),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(AppColors.delete),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/register");
                  },
                  child: const Text('Novo na plataforma? Cadastre-se!'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
