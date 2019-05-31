import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/Constants.dart';

class MainPage extends StatelessWidget {

  Padding getPadding(BuildContext context, String tag, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(tag);
        },
        padding: EdgeInsets.all(12),
        color: appGreyColor,
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final logo = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: bigRadius,
      child: appLogo,
    );

    final loginButton = getPadding(context, loginPageTag, loginPageText);
    final demo1Button = getPadding(context, demo1PageTag, demo1PageText);
    final demo2Button = getPadding(context, demo2PageTag, demo2PageText);
    final demo3Button = getPadding(context, demo3PageTag, demo3PageText);
    final demo4Button = getPadding(context, demo4PageTag, demo4PageText);
    final demo5Button = getPadding(context, demo5PageTag, demo5PageText);

    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        backgroundColor: appDarkGreyColor,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: bigRadius),
              loginButton,
              demo1Button,
              demo2Button,
              demo3Button,
              demo4Button,
              demo5Button,
            ],
          ),
        ),
      ),
    );
  }
}
