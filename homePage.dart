import 'package:flutter/material.dart';
import 'package:mobile_ver/appbar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: [
          AppBarCustom("Home", Size(double.infinity, 50), () {}),
        ],
      ),
    );
  }
}
