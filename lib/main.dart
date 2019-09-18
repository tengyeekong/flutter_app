import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/Constants.dart';
import 'package:flutter_app/pages/DetailsPage.dart';
import 'package:flutter_app/pages/FriendlyChatPage.dart';
import 'package:flutter_app/pages/NewSoftPage.dart';
import 'package:flutter_app/pages/TimerPage.dart';
import 'package:flutter_app/pages/LoginPage.dart';
import 'package:flutter_app/pages/HomePage.dart';
import 'package:flutter_app/pages/Demo1Page.dart';
import 'package:flutter_app/pages/Demo2Page.dart';
import 'package:flutter_app/pages/Demo3Page.dart';
import 'package:flutter_app/pages/Demo4Page.dart';
import 'package:flutter_app/pages/Demo5Page.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(ContactlyApp());

class ContactlyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    timerPageTag: (context) => TimerPage(),
    loginPageTag: (context) => LoginPage(),
    homePageTag: (context) => HomePage(),
    detailsPageTag: (context) => DetailPage(record: ModalRoute.of(context).settings.arguments),
    friendlyChatPageTag: (context) => FriendlyChatPage(),
    demo1PageTag: (context) => Demo1Page(),
    demo2PageTag: (context) => Demo2Page(),
    demo3PageTag: (context) => Demo3Page(),
    demo4PageTag: (context) => Demo4Page(),
    demo5PageTag: (context) => Demo5Page(),
    listingPageTag: (context) => NewSoftPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        theme: defaultTargetPlatform == TargetPlatform.iOS
            ? kIOSTheme
            : kDefaultTheme,
        initialRoute: loginPageTag,
//        home: WillPopScope(
//          onWillPop: () async {
//            return true;
//          },
//          child: LoginPage(),
//        ),
        routes: routes);
  }
}

final ThemeData kIOSTheme = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: Colors.purple,
  primaryColor: appDarkGreyColor,
  accentColor: appDarkGreyColor,
);
