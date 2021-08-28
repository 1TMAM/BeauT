import 'package:buty/Base/shared_preference_manger.dart';
import 'package:buty/Bolcs/creat_order_bloc.dart';
import 'package:buty/UI/bottom_nav_bar/hom_page.dart';
import 'package:buty/UI/bottom_nav_bar/reservations/reservations.dart';
import 'package:buty/UI/component/drawer.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:intl/intl.dart' as intl;
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

  bool isLogged = false;

  void getFromCash() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var logged =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);

    if (logged == "") {
      setState(() {
        isLogged = false;
      });
    } else {
      setState(() {
        isLogged = true;
      });
    }
    print(
        "Valuee ===>  ${mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}");

    print("USER STATUS    ======> ${isLogged == true ? "User" : "Geust"}");
  }

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
    getFromCash();
    if (widget.index == null) {
      setState(() {
        selectedPageIndex = 0;
      });
    } else {
      selectedPageIndex = widget.index;
    }
    get_today_date();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translator.currentLanguage=="ar"?TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
          endDrawer: MyDrawer(
            isLogged: isLogged,
          ),
          key: _drawerKey,
          bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: true,
              selectedIconTheme:
                  IconThemeData(size: 26, color: Theme.of(context).primaryColor),
              unselectedIconTheme: IconThemeData(size: 20, color: Colors.grey),
              showSelectedLabels: true,
              type: BottomNavigationBarType.fixed,
              currentIndex: selectedPageIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      size: 30,
                      color: Colors.grey,
                    ),
                    activeIcon: Icon(
                      Icons.home,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(translator.translate("home"),
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
                    title: Text(translator.translate("notifications"),
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
                    title: Text(translator.translate("reservation"),
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
                    title: Text(translator.translate("more"),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ))),
              ],
              onTap: _onItemTapped),
          body: pages[selectedPageIndex]),
    );
  }

  void get_today_date(){
    final DateTime now = DateTime.now();
    final intl.DateFormat formatter = intl.DateFormat('dd-MM-yyyy');
    final String date_formatted = formatter.format(now);
    createOrderBloc.updateDate(date_formatted);
    sharedPreferenceManager.writeData(CachingKey.RESERVATION_DATE, date_formatted);
  }
}
