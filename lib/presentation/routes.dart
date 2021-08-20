import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/common/constants.dart';
import 'package:flutter_app/data/models/record.dart';

import 'journey/demo_1_page.dart';
import 'journey/demo_2_page.dart';
import 'journey/demo_3_page.dart';
import 'journey/demo_4_page.dart';
import 'journey/demo_5_page.dart';
import 'journey/details_page.dart';
import 'journey/friendly_chat_page.dart';
import 'journey/home_page.dart';
import 'journey/listing_page.dart';
import 'journey/login_page.dart';
import 'journey/test_page.dart';
import 'journey/timer_page.dart';

mixin Routes {
  static final routes = <String, WidgetBuilder>{
    timerPageTag: (context) => TimerPage(),
    loginPageTag: (context) => LoginPage(),
    homePageTag: (context) => HomePage(),
    detailsPageTag: (context) {
      final Object? obj = ModalRoute.of(context)?.settings.arguments;
      if (obj != null && obj is Record) {
        return DetailPage(record: obj);
      }
      return Container();
    },
    friendlyChatPageTag: (context) => FriendlyChatPage(),
    demo1PageTag: (context) => Demo1Page(),
    demo2PageTag: (context) => Demo2Page(),
    demo3PageTag: (context) => Demo3Page(),
    demo4PageTag: (context) => Demo4Page(),
    demo5PageTag: (context) => Demo5Page(),
    listingPageTag: (context) => ListingPage(),
    testPageTag: (context) => TestPage(),
  };
}
