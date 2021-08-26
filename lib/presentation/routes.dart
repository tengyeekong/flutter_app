import 'package:auto_route/auto_route.dart';
import 'package:flutter_app/common/constants/router_constants.dart';

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

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LoginPage, path: RouteName.loginPage),
    AutoRoute(page: HomePage, path: RouteName.homePage),
    AutoRoute(page: DetailPage, path: RouteName.detailsPage),
    AutoRoute(page: TimerPage, path: RouteName.timerPage),
    AutoRoute(page: FriendlyChatPage, path: RouteName.friendlyChatPage),
    AutoRoute(page: Demo1Page, path: RouteName.demo1Page),
    AutoRoute(page: Demo2Page, path: RouteName.demo2Page),
    AutoRoute(page: Demo3Page, path: RouteName.demo3Page),
    AutoRoute(page: Demo4Page, path: RouteName.demo4Page),
    AutoRoute(page: Demo5Page, path: RouteName.demo5Page),
    AutoRoute(page: ListingPage, path: RouteName.listingPage, initial: true),
    AutoRoute(page: TestPage, path: RouteName.testPage),
  ],
)
class $AppRouter {}
