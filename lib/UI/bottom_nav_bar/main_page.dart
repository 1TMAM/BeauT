import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/UI/bottom_nav_bar/hom_page.dart';
import 'package:buty/UI/bottom_nav_bar/reservations/reservations.dart';
import 'package:buty/UI/component/drawer.dart';
import 'package:flutter/material.dart';

import 'more.dart';
import 'notifications.dart';

class MainPage extends StatefulWidget {
  final int index;

  const MainPage({Key key, this.index}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedPageIndex = 0;
  bool isBottomNavigationVisible = true;
  PageController mainPageController = PageController(initialPage: 0);
  List<Widget> pages = [
    HomePage(),
    Notifications(),
    Reservation(),
    More(),
  ];

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  void _onItemTapped(int index) {
    index == 3
        ? _drawerKey.currentState.openEndDrawer()
        : setState(() {
            selectedPageIndex = index;
          });
  }

  @override
  void initState() {
    if (widget.index == null) {
      setState(() {
        selectedPageIndex = 0;
      });
    } else {
      selectedPageIndex = widget.index;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: MyDrawer(),
        key: _drawerKey,
        bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            selectedIconTheme: IconThemeData(
                size: 26, color: Theme.of(context).primaryColor),
            unselectedIconTheme: IconThemeData(size: 20, color: Colors.grey),
            showSelectedLabels: true,
            type: BottomNavigationBarType.shifting,
            currentIndex: selectedPageIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.dashboard,
                    size: 30,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(
                    Icons.dashboard,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(allTranslations.text("home"),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ))),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.notifications,
                    size: 30,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(
                    Icons.notifications,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(allTranslations.text("notifications"),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ))),

              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.calendar_today,
                    size: 30,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(
                    Icons.calendar_today,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(allTranslations.text("reservation"),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ))),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.grey,
                  ),
                  activeIcon: Icon(
                    Icons.person,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(allTranslations.text("more"),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ))),
            ],
            onTap: _onItemTapped),
        body: pages[selectedPageIndex]);
  }
}
