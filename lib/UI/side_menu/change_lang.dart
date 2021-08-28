import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'package:buty/main.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ChangeLanguage extends StatefulWidget {
  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  String lang;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translator.currentLanguage=="ar"?TextDirection.rtl :TextDirection.ltr,

      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              Padding(padding: EdgeInsets.only(right: 10,left: 10),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainPage(
                                index: 0,
                              )));
                    },
                    child:  Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    )),)
            ],
            centerTitle: true,
            title: Text(
              translator.translate("change_language"),
              style: TextStyle(color: Colors.white, fontSize: 14),
            )),
        body: ListView(
          children: [
            InkWell(
              onTap: () async {
                changeLang("ar");
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
                          translator.currentLanguage == "ar"
                              ? Icon(Icons.radio_button_checked)
                              : Icon(Icons.radio_button_unchecked),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(translator.translate("ar")),
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
            InkWell(
              onTap: () => changeLang("en"),
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
                          translator.currentLanguage == "en"
                              ? Icon(Icons.radio_button_checked)
                              : Icon(Icons.radio_button_unchecked),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(translator.translate("en")),
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
          ],
        ),
      ),
    );
  }
  void changeLang(String lang) async {
  setState(() {
    translator.setNewLanguage(
      context,
      newLanguage: '${lang}',
      remember: true,
      restart: false,
    );
  });

    MyApp.setLocale(context, Locale('${lang}'));

  }

}
