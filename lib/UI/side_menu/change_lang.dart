import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class ChangeLanguage extends StatefulWidget {
  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  String lang;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainPage(
                              index: 0,
                            )));
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          centerTitle: true,
          title: Text(
            allTranslations.text("change_language"),
            style: TextStyle(color: Colors.white, fontSize: 14),
          )),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: ()  {
                allTranslations.setNewLanguage("ar", true);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyApp()),
                        (Route<dynamic> route) => false);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                         allTranslations.currentLanguage=="ar"
                              ? Icon(Icons.radio_button_checked)
                              : Icon(Icons.radio_button_unchecked),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(allTranslations.text("ar")),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset("assets/images/sa_flag.png"),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: (){
                allTranslations.setNewLanguage("en", true);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyApp()),
                        (Route<dynamic> route) => false);

              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [

                          allTranslations.currentLanguage=="en"
                              ? Icon(Icons.radio_button_checked)
                              : Icon(Icons.radio_button_unchecked),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(allTranslations.text("en")),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset("assets/images/us_flag.png"),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
