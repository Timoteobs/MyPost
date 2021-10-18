import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypost/service/database_service.dart';
import 'package:mypost/shared/auth/auth_contoller.dart';
import 'package:mypost/shared/models/post_model.dart';
import 'package:mypost/shared/themes/app_colors.dart';

class RestrictedPage extends StatelessWidget {
  const RestrictedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: !DatabaseService().getUSer().emailVerified
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "Area restrita, para visualizar as infomrações, valide seu E-mail"),
              ),
            )
          : Scaffold(
              body: SafeArea(
                child: StreamBuilder<List<Post>>(
                  stream: DatabaseService().listrestRicted(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text("Carregando");
                    }

                    if (snapshot.hasError) {
                      throw 'Something went wrong';
                    }

                    List<Post> posts = snapshot.data!;

                    return Padding(
                      padding: EdgeInsets.all(25),
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.grey[800],
                        ),
                        shrinkWrap: true,
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(index.toString()),
                            child: Text(posts[index].text),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
