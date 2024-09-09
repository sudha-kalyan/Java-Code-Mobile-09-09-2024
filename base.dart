import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_ver/appbar.dart';
import 'package:mobile_ver/homePage.dart';
import 'package:mobile_ver/navbar/navbar.dart';

class BasePage extends StatefulWidget {
  String title;
  Widget screen;
  bool isMenuOpen = false;
  BasePage(this.title, this.screen);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  onMenuBtnPress() {
    setState(() {
      widget.isMenuOpen = !widget.isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 130, 166, 203),
      body: Stack(
        children: [
          AnimatedPositioned(
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 100),
              width: widget.isMenuOpen ? 288 : 0,
              left: widget.isMenuOpen ? 0 : -288,
              height: MediaQuery.of(context).size.height,
              child: nvbTop()),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, .001)
              ..rotateY(widget.isMenuOpen ? 1 - 30 * pi / 180 : 0),
            child: Transform.translate(
                offset: widget.isMenuOpen ? Offset(288, 0) : Offset(0, 0),
                child: Transform.scale(
                    scale: widget.isMenuOpen ? 0.9 : 1,
                    child: ClipRRect(
                        borderRadius: widget.isMenuOpen
                            ? BorderRadius.all(Radius.circular(10))
                            : BorderRadius.all(Radius.circular(0)),
                        child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/backdrop.png'),
                                  fit: BoxFit.cover,
                                  colorFilter: new ColorFilter.mode(
                                      Colors.black.withOpacity(0.8),
                                      BlendMode.dstATop)),
                            ),
                            child: widget.screen)))),
          ),
          Transform.translate(
            offset: Offset(0, 0),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(30),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white),
                  child: IconButton(
                    icon:
                        Icon(widget.isMenuOpen ? Icons.close : Icons.menu_open),
                    onPressed: onMenuBtnPress,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
