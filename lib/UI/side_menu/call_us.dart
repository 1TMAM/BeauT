
import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:url_launcher/url_launcher.dart';

class CallUs extends StatefulWidget {
  @override
  _CallUsState createState() => _CallUsState();
}

class _CallUsState extends State<CallUs> {
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
              translator.translate("call_us"),
              style: TextStyle(color: Colors.white, fontSize: 14),
            )),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: InkWell(
                onTap: (){
                  _launchURL('tel:0530209074');
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(
                        "assets/images/call_phone.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Text(
                      "${translator.translate("Contact  Us On")}  ${translator.translate("phone")}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: InkWell(
                onTap: (){
                  _launchURL(
                      'https://api.whatsapp.com/send?phone=+966530209074');                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(
                        "assets/images/whats.png",
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Text(
                      "${translator.translate("Contact  Us On")} ${translator.translate("whats")}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: InkWell(
                onTap: (){
                  _launchURL('https://instagram.com/beaut_ksa?igshid=ut2jzgyerofo');
                  },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(
                        "assets/images/instagram.png",
                        width: 20,
                        height: 20,

                      ),
                    ),
                    Text(
                      "${translator.translate("Contact  Us On")}  ${translator.translate("Instagram")}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: InkWell(
                onTap: (){
                  _launchURL(
                      'mailto:Info@beautsa.com');
                },
                child: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(
                          Icons.mail,
                          color: Theme.of(context).primaryColor,
                        )),
                    Text(
                      "${translator.translate("Contact  Us On")}  ${translator.translate("e_mail")}",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }


  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
