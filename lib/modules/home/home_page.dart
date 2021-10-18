import 'package:flutter/material.dart';
import 'package:mypost/modules/home/home_controller.dart';
import 'package:mypost/service/database_service.dart';
import 'package:mypost/shared/models/post_model.dart';
import 'package:mypost/shared/nav/nav_bar.dart';
import 'package:mypost/shared/themes/app_colors.dart';
import 'package:mypost/shared/themes/app_text_styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController();
  final _post = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: AppColors.primary,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Row(
                  children: [
                    const Text("Novo Post"),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.cancel),
                    )
                  ],
                ),
                children: [
                  TextFormField(
                    controller: _post,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: "O que está acontecendo?",
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(AppColors.primary),
                      ),
                      onPressed: () async {
                        if (_post.text.isNotEmpty) {
                          await DatabaseService().createNewPost(
                            _post.text.trim(),
                          );
                          _post.clear();
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Postar'),
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
      body: SafeArea(
        child: StreamBuilder<List<Post>>(
          stream: DatabaseService().listPosts(),
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
    );
  }
}
