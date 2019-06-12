import 'package:flutter/material.dart';
import 'Pages/FriendlyChatPage.dart';
import 'helpers/Constants.dart';
import 'Pages/TimerPage.dart';
import 'Pages/LoginPage.dart';
import 'Pages/HomePage.dart';
import 'Pages/Demo1Page.dart';
import 'Pages/Demo2Page.dart';
import 'Pages/Demo3Page.dart';
import 'Pages/Demo4Page.dart';
import 'Pages/Demo5Page.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(ContactlyApp());

class ContactlyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    timerPageTag: (context) => TimerPage(),
    loginPageTag: (context) => LoginPage(),
    homePageTag: (context) => HomePage(),
    FriendlyChatPageTag: (context) => FriendlyChatPage(),
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
        theme: defaultTargetPlatform == TargetPlatform.iOS
            ? kIOSTheme
            : kDefaultTheme,
        home: LoginPage(),
        routes: routes);
  }
}

final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  primaryColor: appDarkGreyColor,
  accentColor: appDarkGreyColor,
);
