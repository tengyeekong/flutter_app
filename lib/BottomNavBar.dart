import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/Constants.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: appDarkGreyColor,
      ),
      child: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white30,
        currentIndex: 8,
        type: BottomNavigationBarType.shifting,
        items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(loginButtonText),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(FriendlyChatPageText),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(timerPageText),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(demo1PageText),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(demo2PageText),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(demo3PageText),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(demo4PageText),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(demo5PageText),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(listingPageText),
        ),
      ],
      onTap: (index) {
        _onTapped(context, index);
      },),
    );
  }

  _onTapped(BuildContext context, int index) {
    String tag = "";
    switch(index) {
//      case 0: tag = loginPageTag; break;
      case 1: tag = friendlyChatPageTag; break;
      case 2: tag = timerPageTag; break;
      case 3: tag = demo1PageTag; break;
      case 4: tag = demo2PageTag; break;
      case 5: tag = demo3PageTag; break;
      case 6: tag = demo4PageTag; break;
      case 7: tag = demo5PageTag; break;
      case 8: tag = listingPageTag; break;
      default: tag = loginPageTag; break;
    }

    if (ModalRoute.of(context).settings.name != tag) {
      Navigator.of(context).pushNamed(tag);
    }
  }
}
