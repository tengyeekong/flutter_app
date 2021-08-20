import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/routes.dart';

import 'common/constants/color_constants.dart';
import 'common/constants/router_constants.dart';
import 'common/constants/string_constants.dart';
import 'common/injector/injector.dart';
import 'common/my_logger.dart';

void main() {
  Injector.init();
  MyLogger.init();
  runApp(ContactlyApp());
}

class ContactlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
//        home: WillPopScope(
//          onWillPop: () async {
//            return true;
//          },
//          child: LoginPage(),
//        ),
      initialRoute: RouteName.listingPage,
      onGenerateRoute: Routes.generateRoute,
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
