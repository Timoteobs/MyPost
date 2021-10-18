import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypost/service/database_service.dart';
import 'package:mypost/shared/auth/auth_contoller.dart';
import 'package:mypost/shared/models/user_model.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = AuthController();

    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(DatabaseService().getUSer().name),
            accountEmail: Text(DatabaseService().getUSer().email),
            currentAccountPicture: ClipOval(
              child: Image.network(
                DatabaseService().getUSer().photoURL == null
                    ? 'https://cdn.pixabay.com/photo/2016/11/22/22/21/adventure-1850912_960_720.jpg'
                    : DatabaseService().getUSer().photoURL,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Meu Perfil"),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text("Validar Email"),
            onTap: () => DatabaseService().checkEmail(),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Sair"),
            onTap: () => authController.logout(context),
          )
        ],
      ),
    );
  }
}
