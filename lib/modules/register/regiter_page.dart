import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypost/modules/login/login_controller.dart';
import 'package:mypost/modules/register/register_controller.dart';
import 'package:mypost/shared/custominput/custom_input_box.dart';
import 'package:mypost/shared/models/register_model.dart';
import 'package:mypost/shared/social_login/social_login_button.dart';
import 'package:mypost/shared/themes/app_colors.dart';
import 'package:mypost/shared/themes/app_text_styles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = LoginController();
  final registerController = RegisterController();
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  bool _agree = false;

  alertAgree() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alerta'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'Verificamos que você não aceitou os termos e condições 😕'),
                Text('Só será possível concluir o cadastro após o aceite.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tudo Bem!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  register() {
    if (!_agree) {
      return alertAgree();
    }

    if (_form.currentState!.validate()) {
      final model = RegisterModel(
        email: _email.text,
        name: _name.text,
        password: _password.text,
      );
      registerController.registerUser(model, context);
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
                      "Cadastre-se",
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
                        if (!_agree) {
                          return alertAgree();
                        }
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
                        label: "Nome",
                        hint: 'Informe seu nome',
                        controller: _name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Informe seu nome.";
                          }
                        },
                      ),
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
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35),
                        child: Row(
                          children: [
                            Material(
                              child: Checkbox(
                                value: _agree,
                                onChanged: (value) {
                                  setState(() {
                                    _agree = value ?? false;
                                  });
                                },
                              ),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColors.primary),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SimpleDialog(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 25),
                                      title: Row(
                                        children: [
                                          const Text("Termos e Condições"),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            icon: const Icon(Icons.cancel),
                                          )
                                        ],
                                      ),
                                      children: [
                                        const Text(
                                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                'Eu li e aceito os termos e condições',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ],
                        ),
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
                      onPressed: register,
                      style:
                          ElevatedButton.styleFrom(primary: AppColors.primary),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              "Registrar",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
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
                    Navigator.pop(context, "/login");
                  },
                  child: const Text('Já está cadastrado? Faça login!'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
