import 'package:flutter/material.dart';
import 'helpers/Constants.dart';
import 'Pages/TimerPage.dart';
import 'Pages/LoginPage.dart';
import 'Pages/Demo1Page.dart';
import 'Pages/Demo2Page.dart';
import 'Pages/Demo3Page.dart';
import 'Pages/Demo4Page.dart';
import 'Pages/Demo5Page.dart';

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
        color: appGreyColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
//              child: Text('Drawer Header', style: TextStyle(color: Colors.white)),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
            ),
            getListTile(context, LoginPage(), loginPageText),
            getListTile(context, TimerPage(), timerPageText),
            getListTile(context, Demo1Page(), demo1PageText),
            getListTile(context, Demo2Page(), demo2PageText),
            getListTile(context, Demo3Page(), demo3PageText),
            getListTile(context, Demo4Page(), demo4PageText),
            getListTile(context, Demo5Page(), demo5PageText),
          ]
        ),
      )
    );
  }

  ListTile getListTile(BuildContext context, Widget widget, String text) {
    return ListTile(
      title: Text(text, style: TextStyle(color: Colors.white)),
      onTap: () {
//        Navigator.of(context).pushNamed(tag);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => widget)
        );
      },
    );
  }
}
