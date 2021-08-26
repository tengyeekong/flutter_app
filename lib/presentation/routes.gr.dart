// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../data/models/record.dart' as _i15;
import 'journey/demo_1_page.dart' as _i8;
import 'journey/demo_2_page.dart' as _i9;
import 'journey/demo_3_page.dart' as _i10;
import 'journey/demo_4_page.dart' as _i11;
import 'journey/demo_5_page.dart' as _i12;
import 'journey/details_page.dart' as _i5;
import 'journey/friendly_chat_page.dart' as _i7;
import 'journey/home_page.dart' as _i4;
import 'journey/listing_page.dart' as _i13;
import 'journey/login_page.dart' as _i3;
import 'journey/test_page.dart' as _i14;
import 'journey/timer_page.dart' as _i6;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i3.LoginPage();
        }),
    HomeRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.HomePage();
        }),
    DetailRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<DetailRouteArgs>();
          return _i5.DetailPage(record: args.record);
        }),
    TimerRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i6.TimerPage();
        }),
    FriendlyChatRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i7.FriendlyChatPage();
        }),
    Demo1Route.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i8.Demo1Page();
        }),
    Demo2Route.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i9.Demo2Page();
        }),
    Demo3Route.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i10.Demo3Page();
        }),
    Demo4Route.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i11.Demo4Page();
        }),
    Demo5Route.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i12.Demo5Page();
        }),
    ListingRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i13.ListingPage();
        }),
    TestRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i14.TestPage();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig('/#redirect',
            path: '/', redirectTo: '/listing', fullMatch: true),
        _i1.RouteConfig(LoginRoute.name, path: '/login'),
        _i1.RouteConfig(HomeRoute.name, path: '/home'),
        _i1.RouteConfig(DetailRoute.name, path: '/home/detail'),
        _i1.RouteConfig(TimerRoute.name, path: '/timer'),
        _i1.RouteConfig(FriendlyChatRoute.name, path: '/friendlychat'),
        _i1.RouteConfig(Demo1Route.name, path: '/demo1'),
        _i1.RouteConfig(Demo2Route.name, path: '/demo2'),
        _i1.RouteConfig(Demo3Route.name, path: '/demo3'),
        _i1.RouteConfig(Demo4Route.name, path: '/demo4'),
        _i1.RouteConfig(Demo5Route.name, path: '/demo5'),
        _i1.RouteConfig(ListingRoute.name, path: '/listing'),
        _i1.RouteConfig(TestRoute.name, path: '/test')
      ];
}

class LoginRoute extends _i1.PageRouteInfo {
  const LoginRoute() : super(name, path: '/login');

  static const String name = 'LoginRoute';
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '/home');

  static const String name = 'HomeRoute';
}

class DetailRoute extends _i1.PageRouteInfo<DetailRouteArgs> {
  DetailRoute({required _i15.Record record})
      : super(name,
            path: '/home/detail', args: DetailRouteArgs(record: record));

  static const String name = 'DetailRoute';
}

class DetailRouteArgs {
  const DetailRouteArgs({required this.record});

  final _i15.Record record;
}

class TimerRoute extends _i1.PageRouteInfo {
  const TimerRoute() : super(name, path: '/timer');

  static const String name = 'TimerRoute';
}

class FriendlyChatRoute extends _i1.PageRouteInfo {
  const FriendlyChatRoute() : super(name, path: '/friendlychat');

  static const String name = 'FriendlyChatRoute';
}

class Demo1Route extends _i1.PageRouteInfo {
  const Demo1Route() : super(name, path: '/demo1');

  static const String name = 'Demo1Route';
}

class Demo2Route extends _i1.PageRouteInfo {
  const Demo2Route() : super(name, path: '/demo2');

  static const String name = 'Demo2Route';
}

class Demo3Route extends _i1.PageRouteInfo {
  const Demo3Route() : super(name, path: '/demo3');

  static const String name = 'Demo3Route';
}

class Demo4Route extends _i1.PageRouteInfo {
  const Demo4Route() : super(name, path: '/demo4');

  static const String name = 'Demo4Route';
}

class Demo5Route extends _i1.PageRouteInfo {
  const Demo5Route() : super(name, path: '/demo5');

  static const String name = 'Demo5Route';
}

class ListingRoute extends _i1.PageRouteInfo {
  const ListingRoute() : super(name, path: '/listing');

  static const String name = 'ListingRoute';
}

class TestRoute extends _i1.PageRouteInfo {
  const TestRoute() : super(name, path: '/test');

  static const String name = 'TestRoute';
}
