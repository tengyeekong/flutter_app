import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/constants.dart';
import 'package:flutter_app/presentation/routes.dart';

import 'common/injector/injector.dart';

void main() {
  Injector.setup();
  runApp(ContactlyApp());
}

class ContactlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        theme: defaultTargetPlatform == TargetPlatform.iOS
            ? kIOSTheme.copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              )
            : kDefaultTheme.copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
        initialRoute: loginPageTag,
//        home: WillPopScope(
//          onWillPop: () async {
//            return true;
//          },
//          child: LoginPage(),
//        ),
        routes: Routes.routes);
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
