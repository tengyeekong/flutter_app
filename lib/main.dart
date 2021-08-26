import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/routes.gr.dart';
import 'package:injectable/injectable.dart';

import 'common/constants/color_constants.dart';
import 'common/constants/string_constants.dart';
import 'common/injector/injector.dart';
import 'common/my_logger.dart';

void main() {
  configureInjection(Environment.dev);
  MyLogger.init();
  runApp(ContactlyApp());
}

class ContactlyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: strAppTitle,
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme.copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            )
          : kDefaultTheme.copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
      routerDelegate: AutoRouterDelegate(_appRouter),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}

final ThemeData kIOSTheme = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: Colors.purple,
  primaryColor: colorAppDarkGrey,
  accentColor: colorAppDarkGrey,
);
