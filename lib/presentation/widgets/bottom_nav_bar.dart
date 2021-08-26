import 'package:flutter/material.dart';
import 'package:flutter_app/common/constants/color_constants.dart';
import 'package:flutter_app/common/constants/router_constants.dart';
import 'package:flutter_app/common/constants/string_constants.dart';

class BottomNavBar extends StatefulWidget {
  final double yTransValue;

  const BottomNavBar({
    Key? key,
    required this.yTransValue,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: colorAppDarkGrey,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.translationValues(0, widget.yTransValue, 0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 8.0, 50.0, 20.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(0, 4),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8),
                ),
                child: BottomNavigationBar(
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white30,
                  currentIndex: _selectedIndex,
                  elevation: 16.0,
                  showSelectedLabels: false,
                  enableFeedback: false,
                  showUnselectedLabels: false,
                  type: BottomNavigationBarType.fixed,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: strLoginButton,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: strFriendlyChatPage,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: strTimerPage,
                    ),
                    // BottomNavigationBarItem(
                    //   icon: Icon(Icons.home),
                    //   label: demo1PageText,
                    // ),
                    // BottomNavigationBarItem(
                    //   icon: Icon(Icons.home),
                    //   label: demo2PageText,
                    // ),
                    // BottomNavigationBarItem(
                    //   icon: Icon(Icons.home),
                    //   label: demo3PageText,
                    // ),
                    // BottomNavigationBarItem(
                    //   icon: Icon(Icons.home),
                    //   label: demo4PageText,
                    // ),
                    // BottomNavigationBarItem(
                    //   icon: Icon(Icons.home),
                    //   label: demo5PageText,
                    // ),
                    // BottomNavigationBarItem(
                    //   icon: Icon(Icons.home),
                    //   label: listingPageText,
                    // ),
                  ],
                  onTap: (index) {
                    _onTapped(context, index);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapped(BuildContext context, int index) {
    String tag = "";
    switch (index) {
      case 0:
        tag = RouteName.loginPage;
        break;
      case 1:
        tag = RouteName.friendlyChatPage;
        break;
      case 2:
        tag = RouteName.timerPage;
        break;
      case 3:
        tag = RouteName.demo1Page;
        break;
      case 4:
        tag = RouteName.demo2Page;
        break;
      case 5:
        tag = RouteName.demo3Page;
        break;
      case 6:
        tag = RouteName.demo4Page;
        break;
      case 7:
        tag = RouteName.demo5Page;
        break;
      case 8:
        tag = RouteName.listingPage;
        break;
      default:
        tag = RouteName.loginPage;
        break;
    }

    setState(() {
      _selectedIndex = index;
    });
    // if (ModalRoute.of(context)?.settings.name != tag) {
    //   AutoRouter.of(context).pushNamed(tag);
    // }
  }
}
