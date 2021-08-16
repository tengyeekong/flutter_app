import 'package:flutter/material.dart';
import 'package:flutter_app/common/Constants.dart';
import 'dart:async';
import 'package:flutter/services.dart';

import 'package:flutter_app/presentation/widgets/AppDrawer.dart';

class TimerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TimerState();
  }
}

class _TimerState extends State<TimerPage> {
  static const duration = const Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  String loginBtnText = loginButtonText;
  Timer? timer;

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null)
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });

    // pause timer when app paused
    SystemChannels.lifecycle.setMessageHandler((msg) async {
      debugPrint('SystemChannels> $msg');
      if (msg == AppLifecycleState.paused.toString())
        setState(() {
          isActive = false;
        });
//      else setState(() {isActive = true;});
    });

    const int UNIT = 60;
    int seconds = secondsPassed % UNIT;
    int minutes = secondsPassed ~/ UNIT;
    int hours = secondsPassed ~/ (UNIT * UNIT);

    final timerWidget = Container(
        margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTextContainer(
                      label: 'HRS', value: hours.toString().padLeft(2, '0')),
                  CustomTextContainer(
                      label: 'MIN', value: minutes.toString().padLeft(2, '0')),
                  CustomTextContainer(
                      label: 'SEC', value: seconds.toString().padLeft(2, '0')),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: RaisedButton(
                  child: Text(isActive ? 'STOP' : 'START'),
                  onPressed: () {
                    setState(() {
                      isActive = !isActive;
                    });
                  },
                ),
              )
            ]));

    return Scaffold(
      backgroundColor: appDarkGreyColor,
      drawer: AppDrawer(),
      appBar: AppBar(
          elevation: 0.1,
          backgroundColor: appDarkGreyColor,
          centerTitle: true,
          title: Text("Timer"),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
//          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            timerWidget
          ],
        ),
      ),
    );
  }
}

class CustomTextContainer extends StatelessWidget {
  CustomTextContainer({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black87,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
              color: Colors.white,
              fontSize: 54,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white70,
            ),
          )
        ],
      ),
    );
  }
}
