import 'package:flutter/material.dart';
import 'helpers/Constants.dart';
import 'MainPage.dart';
import 'LoginPage.dart';
import 'HomePage.dart';

void main() => runApp(ContactlyApp());

class ContactlyApp extends StatelessWidget {

  final routes = <String, WidgetBuilder>{
    mainPageTag: (context) => MainPage(),
    loginPageTag: (context) => LoginPage(),
    homePageTag: (context) => HomePage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: new ThemeData(
        primaryColor: appDarkGreyColor,
      ),
      home: MainPage(),
      routes: routes
    );
  }

}
