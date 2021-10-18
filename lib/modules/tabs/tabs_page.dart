import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypost/modules/home/home_page.dart';
import 'package:mypost/modules/restricted/restricted_page.dart';
import 'package:mypost/shared/nav/nav_bar.dart';
import 'package:mypost/shared/themes/app_colors.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: Text("MyPost"),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          bottom: const TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(
                text: "Home",
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ),
              Tab(
                text: "Restrito",
                icon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HomePage(),
            RestrictedPage(),
          ],
        ),
      ),
    );
  }
}
