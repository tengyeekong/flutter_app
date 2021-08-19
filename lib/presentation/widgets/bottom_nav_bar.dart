import 'package:flutter/material.dart';
import 'package:flutter_app/common/constants.dart';

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
        canvasColor: appDarkGreyColor,
      ),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(0, 4),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
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
                      label: loginButtonText,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: FriendlyChatPageText,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: timerPageText,
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

  _onTapped(BuildContext context, int index) {
    String tag = "";
    switch (index) {
      case 0:
        tag = loginPageTag;
        break;
      case 1:
        tag = friendlyChatPageTag;
        break;
      case 2:
        tag = timerPageTag;
        break;
      case 3:
        tag = demo1PageTag;
        break;
      case 4:
        tag = demo2PageTag;
        break;
      case 5:
        tag = demo3PageTag;
        break;
      case 6:
        tag = demo4PageTag;
        break;
      case 7:
        tag = demo5PageTag;
        break;
      case 8:
        tag = listingPageTag;
        break;
      default:
        tag = loginPageTag;
        break;
    }

    setState(() {
      _selectedIndex = index;
    });
    // if (ModalRoute.of(context)?.settings.name != tag) {
    //   Navigator.of(context).pushNamed(tag);
    // }
  }
}
