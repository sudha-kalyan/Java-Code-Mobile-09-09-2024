import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:mobile_ver/base.dart';
import 'package:mobile_ver/homePage.dart';
import 'package:localstorage/localstorage.dart' as localstorage;
import 'package:mobile_ver/login.dart';
import 'navbar/navbar.dart';

//final String main_url = "http://localhost:9930/";

final String main_url = "http://192.168.29.199:9930/";
//final String main_url = "http://192.168.220.87:9930/";
final SessionManager sessionManager = SessionManager();

final localstorage.LocalStorage storage =
    localstorage.LocalStorage('RaithannaDairy_local');

void main() {
  storage.clear();
  storage.setItem('loggedIn', false);
  storage.setItem('loggePhone', null);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  BuildContext? contextt;
  Timer? timer = null;
  int seconds = 0;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (seconds == 360) {
        seconds = 0;

        stoptime();
        storage.clear();
        storage.setItem('loggedIn', false);
        storage.setItem('loggePhone', null);
      } else {
        seconds++;
        print(seconds);
      }
    });
  }

  void stoptime() {
    timer?.cancel();
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logged out expired'),backgroundColor: Colors.red,));
    navigatorKey.currentState
        ?.pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.detached) {
      storage.clear();
      storage.setItem('loggedIn', false);
      storage.setItem('loggePhone', null);
    } else if (state == AppLifecycleState.inactive) {
      print('inactive');

      startTimer();
    } else if (state == AppLifecycleState.paused) {
    } else if (state == AppLifecycleState.resumed) {
      timer?.cancel();

      seconds = 0;

      print('resumed');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airavat dairy',
      theme: ThemeData(
        scaffoldBackgroundColor:
            Colors.transparent, //const Color.fromARGB(255, 130, 166, 203),,
        primarySwatch: Colors.blueGrey,
        fontFamily: "Intel",
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
      ),
      home: BasePage("home", HomePage()),
      debugShowCheckedModeBanner: false,
    );
  }
}
