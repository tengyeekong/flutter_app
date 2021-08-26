import 'package:flutter/material.dart';
import 'package:flutter_app/common/constants/color_constants.dart';
import 'package:flutter_app/common/constants/router_constants.dart';
import 'package:flutter_app/common/constants/string_constants.dart';
import 'package:flutter_app/common/injector/injector.dart';

import '../routes.gr.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DrawerState();
  }
}

class DrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: colorAppGrey,
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
            child: Center(
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          getListTile(context, RouteName.listingPage, strListingPage),
          getListTile(context, RouteName.testPage, strTestPage),
          getListTile(context, RouteName.loginPage, strLoginPage),
          getListTile(context, RouteName.friendlyChatPage, strFriendlyChatPage),
          getListTile(context, RouteName.timerPage, strTimerPage),
          getListTile(context, RouteName.demo1Page, strDemo1Page),
          getListTile(context, RouteName.demo2Page, strDemo2Page),
          getListTile(context, RouteName.demo3Page, strDemo3Page),
          getListTile(context, RouteName.demo4Page, strDemo4Page),
          getListTile(context, RouteName.demo5Page, strDemo5Page),
        ]),
      ),
    );
  }

  ListTile getListTile(BuildContext context, String tag, String text) {
    return ListTile(
      title: Text(text, style: const TextStyle(color: Colors.white)),
      onTap: () {
        getIt<AppRouter>().pop();
        if (getIt<AppRouter>().currentChild?.path != tag) {
          getIt<AppRouter>().pushNamed(tag);

//          getIt<AppRouter>().pushNamedAndRemoveUntil(
//              tag,
//              (route) => route.isCurrent
//                  ? route.settings.name == tag ? false : true
//                  : true);
        }

//        getIt<AppRouter>().pop(context);
//        getIt<AppRouter>().push(context, MaterialPageRoute(
//            builder: (context) => widgets)
//        );
      },
    );
  }
}
