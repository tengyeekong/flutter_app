import 'package:flutter/material.dart';
import 'package:flutter_app/common/constants.dart';

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
          getListTile(context, listingPageTag, listingPageText),
          getListTile(context, testPageTag, testPageText),
          getListTile(context, loginPageTag, loginPageText),
          getListTile(context, friendlyChatPageTag, friendlyChatPageText),
          getListTile(context, timerPageTag, timerPageText),
          getListTile(context, demo1PageTag, demo1PageText),
          getListTile(context, demo2PageTag, demo2PageText),
          getListTile(context, demo3PageTag, demo3PageText),
          getListTile(context, demo4PageTag, demo4PageText),
          getListTile(context, demo5PageTag, demo5PageText),
        ]),
      ),
    );
  }

  ListTile getListTile(BuildContext context, String tag, String text) {
    return ListTile(
      title: Text(text, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.of(context).pop();
        if (ModalRoute.of(context)?.settings.name != tag) {
          Navigator.of(context).pushNamed(tag);

//          Navigator.of(context).pushNamedAndRemoveUntil(
//              tag,
//              (route) => route.isCurrent
//                  ? route.settings.name == tag ? false : true
//                  : true);
        }

//        Navigator.pop(context);
//        Navigator.push(context, MaterialPageRoute(
//            builder: (context) => widgets)
//        );
      },
    );
  }
}
