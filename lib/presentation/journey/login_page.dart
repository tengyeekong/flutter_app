import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/common/constants/color_constants.dart';
import 'package:flutter_app/common/constants/image_constants.dart';
import 'package:flutter_app/common/constants/router_constants.dart';
import 'package:flutter_app/common/constants/string_constants.dart';
import 'package:flutter_app/common/constants/value_constants.dart';
import 'package:flutter_app/common/injector/injector.dart';
import 'package:flutter_app/presentation/widgets/app_drawer.dart';

import '../routes.gr.dart';

class LoginPage extends StatelessWidget {
  final _pinCodeController = TextEditingController();
  final String loginBtnText = strLoginButton;

  @override
  Widget build(BuildContext context) {
    final logo = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: valBigRadius,
      child: Images.appLogo,
    );

    final pinCode = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        color: Colors.transparent,
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
//            spreadRadius: 2.0,
//            blurRadius: 12.0,
          ),
          BoxShadow(
            color: Color.fromRGBO(64, 75, 96, 0.9),
//            spreadRadius: 8.0,
            blurRadius: 12.0,
          ),
        ],
      ),
      child: TextFormField(
        controller: _pinCodeController,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        obscureText: true,
        maxLength: 4,
        decoration: InputDecoration(
            counterText: "",
            counterStyle: const TextStyle(color: Colors.white),
            hintText: strPinCodeHint,
            contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: const BorderSide(color: Color.fromRGBO(0, 0, 0, 0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: const BorderSide(color: Color.fromRGBO(0, 0, 0, 0)),
            ),
            hintStyle: const TextStyle(color: Colors.white)),
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );

//    final pinCode = TextFormField(
//      controller: _pinCodeController,
//      keyboardType: TextInputType.number,
//      inputFormatters: <TextInputFormatter>[
//        WhitelistingTextInputFormatter.digitsOnly
//      ],
//      obscureText: true,
//      maxLength: 4,
//      maxLines: 1,
//      decoration: InputDecoration(
//          counterText: "",
//          counterStyle: TextStyle(color: Colors.white),
//          hintText: pinCodeHintText,
//          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//          enabledBorder: OutlineInputBorder(
//            borderRadius: BorderRadius.circular(32.0),
//            borderSide: BorderSide(color: Colors.black45),
//          ),
//          focusedBorder: OutlineInputBorder(
//            borderRadius: BorderRadius.circular(32.0),
//            borderSide: BorderSide(color: Colors.black45),
//          ),
//          hintStyle: TextStyle(color: Colors.white)),
//      style: TextStyle(
//        color: Colors.white,
//      ),
//    );

    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.all(12)),
          backgroundColor: MaterialStateProperty.all<Color>(colorAppGrey),
        ),
        onPressed: () {
          getIt<AppRouter>().pushNamed(RouteName.homePage);
//          setState(() {loginBtnText = _pinCodeController.text;});
        },
        child: Text(loginBtnText, style: const TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: colorAppDarkGrey,
      drawer: AppDrawer(),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            const SizedBox(height: valBigRadius),
            pinCode,
            const SizedBox(height: valBtnHeight),
            loginButton
          ],
        ),
      ),
    );
  }
}
