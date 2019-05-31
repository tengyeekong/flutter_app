import 'package:flutter/material.dart';
import 'helpers/Constants.dart';

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final logo = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: bigRadius,
      child: appLogo,
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(loginPageTag);
        },
        padding: EdgeInsets.all(12),
        color: appGreyColor,
        child: Text(loginPageText, style: TextStyle(color: Colors.white)),
      ),
    );

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
              loginButton
            ],
          ),
        ),
      ),
    );
  }
}
