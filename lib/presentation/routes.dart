import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/common/Constants.dart';
import 'package:flutter_app/data/models/Record.dart';

import 'journey/Demo1Page.dart';
import 'journey/Demo2Page.dart';
import 'journey/Demo3Page.dart';
import 'journey/Demo4Page.dart';
import 'journey/Demo5Page.dart';
import 'journey/DetailsPage.dart';
import 'journey/FriendlyChatPage.dart';
import 'journey/HomePage.dart';
import 'journey/LoginPage.dart';
import 'journey/NewSoftPage.dart';
import 'journey/TimerPage.dart';

class Routes {
  static final routes = <String, WidgetBuilder>{
    timerPageTag: (context) => TimerPage(),
    loginPageTag: (context) => LoginPage(),
    homePageTag: (context) => HomePage(),
    detailsPageTag: (context) => DetailPage(
        record: ModalRoute.of(context)?.settings.arguments as Record),
    friendlyChatPageTag: (context) => FriendlyChatPage(),
    demo1PageTag: (context) => Demo1Page(),
    demo2PageTag: (context) => Demo2Page(),
    demo3PageTag: (context) => Demo3Page(),
    demo4PageTag: (context) => Demo4Page(),
    demo5PageTag: (context) => Demo5Page(),
    listingPageTag: (context) => NewSoftPage(),
  };
}
