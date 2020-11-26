import 'package:buty/UI/Auth/spash.dart';
import 'package:buty/UI/CustomWidgets/app_logo.dart';
import 'package:buty/UI/side_menu/address/myAddress.dart';
import 'package:buty/UI/side_menu/call_us.dart';
import 'package:buty/UI/side_menu/cards/my_cards.dart';
import 'package:buty/UI/side_menu/change_lang.dart';
import 'package:buty/UI/side_menu/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  final bool isLogged;

  const MyDrawer({Key key, this.isLogged}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          color: Theme.of(context).primaryColor,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            children: [
              AppLogo(),
              SizedBox(
                height: 30,
              ),
              itemRow("${translator.translate("edit_profile")}",
                  Icons.person_outline, EditProfile()),
              itemRow("${translator.translate("add_address")}",
                  Icons.location_on, MyAddresses()),
              itemRow("${translator.translate("add_cridit")}",
                  Icons.credit_card, MyCards()),
              itemRow("${translator.translate("change_language")}",
                  Icons.language, ChangeLanguage()),
              itemRow(
                  "${translator.translate("call_us")}", Icons.call, CallUs()),
              widget.isLogged == true
                  ? itemRow("${translator.translate("log_out")}",
                      Icons.arrow_back, Splash())
                  : itemRow("${translator.translate("login")}",
                      Icons.arrow_forward, Splash()),
            ],
          )),
    );
  }

  Widget itemRow(String lable, IconData icon, Widget page) {
    return InkWell(
      onTap: () async {
        if (lable == translator.translate("log_out")) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.clear();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 25,
            ),
            SizedBox(width: 20),
            Text(
              lable,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
