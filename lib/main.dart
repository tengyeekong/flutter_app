import 'package:flutter/material.dart';
import 'helpers/Constants.dart';
import 'Pages/TimerPage.dart';
import 'Pages/LoginPage.dart';
import 'Pages/HomePage.dart';
import 'Pages/Demo1Page.dart';
import 'Pages/Demo2Page.dart';
import 'Pages/Demo3Page.dart';
import 'Pages/Demo4Page.dart';
import 'Pages/Demo5Page.dart';

void main() => runApp(ContactlyApp());

class ContactlyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    timerPageTag: (context) => TimerPage(),
    loginPageTag: (context) => LoginPage(),
    homePageTag: (context) => HomePage(),
    demo1PageTag: (context) => Demo1Page(),
    demo2PageTag: (context) => Demo2Page(),
    demo3PageTag: (context) => Demo3Page(),
    demo4PageTag: (context) => Demo4Page(),
    demo5PageTag: (context) => Demo5Page(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        theme: ThemeData(
          primaryColor: appDarkGreyColor,
        ),
        home: LoginPage(),
        routes: routes);
  }
}
