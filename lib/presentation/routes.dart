import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/common/constants/router_constants.dart';
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

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.timerPage:
        return MaterialPageRoute(builder: (_) => TimerPage());
      case RouteName.loginPage:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case RouteName.homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case RouteName.detailsPage:
        final Object? obj = settings.arguments;
        return MaterialPageRoute(
          builder: (_) {
            if (obj != null && obj is Record) {
              return DetailPage(record: obj);
            }
            return Container();
          },
        );
      case RouteName.friendlyChatPage:
        return MaterialPageRoute(builder: (_) => FriendlyChatPage());
      case RouteName.demo1Page:
        return MaterialPageRoute(builder: (_) => Demo1Page());
      case RouteName.demo2Page:
        return MaterialPageRoute(builder: (_) => Demo2Page());
      case RouteName.demo3Page:
        return MaterialPageRoute(builder: (_) => Demo3Page());
      case RouteName.demo4Page:
        return MaterialPageRoute(builder: (_) => Demo4Page());
      case RouteName.demo5Page:
        return MaterialPageRoute(builder: (_) => Demo5Page());
      case RouteName.listingPage:
        return MaterialPageRoute(builder: (_) => ListingPage());
      case RouteName.testPage:
        return MaterialPageRoute(builder: (_) => TestPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
