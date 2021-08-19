import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/common/constants.dart';
import 'package:flutter_app/presentation/widgets/app_drawer.dart';

class LoginPage extends StatelessWidget {
  final _pinCodeController = TextEditingController();
  final String loginBtnText = loginButtonText;

  @override
  Widget build(BuildContext context) {
    final logo = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: bigRadius,
      child: appLogo,
    );

    final pinCode = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        color: Colors.transparent,
        boxShadow: [
          const BoxShadow(
            color: Colors.black38,
            offset: const Offset(0.0, 0.0),
//            spreadRadius: 2.0,
//            blurRadius: 12.0,
          ),
          const BoxShadow(
            color: Color.fromRGBO(64, 75, 96, 0.9),
            offset: const Offset(0.0, 0.0),
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
        maxLines: 1,
        decoration: InputDecoration(
            counterText: "",
            counterStyle: TextStyle(color: Colors.white),
            hintText: pinCodeHintText,
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0)),
            ),
            hintStyle: TextStyle(color: Colors.white)),
        style: TextStyle(
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
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          padding:
              MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(12)),
          backgroundColor: MaterialStateProperty.all<Color>(appGreyColor),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(homePageTag);
//          setState(() {loginBtnText = _pinCodeController.text;});
        },
        child: Text('$loginBtnText', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: appDarkGreyColor,
      drawer: AppDrawer(),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: bigRadius),
            pinCode,
            SizedBox(height: buttonHeight),
            loginButton
          ],
        ),
      ),
    );
  }
}
