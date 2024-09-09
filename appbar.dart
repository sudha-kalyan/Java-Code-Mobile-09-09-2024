import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  String title;
  @override
  final Size preferredSize;
  Function press;
  AppBarCustom(this.title, this.preferredSize, this.press);

  @override
  Widget build(BuildContext context) {
    print(this.press);
    return AppBar(
        backgroundColor: Color.fromARGB(255, 54, 103, 166),
        // leading: IconButton(
        //   icon: Icon(Icons.menu_open),
        //   onPressed: ()=>this.press,
        // ),
        centerTitle: true,
        title: Text(title),
        actions: []);
  }
}
