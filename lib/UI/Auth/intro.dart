import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:buty/UI/Auth/sign_up.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'package:flutter/material.dart';
 import 'login.dart';

class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Image.asset(
            "assets/images/header.png",
            fit: BoxFit.contain,
            width: 100,
            height: 30,
          )),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
            child: Text(
               translator.translate("intro_text"),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          CustomButton(
            onBtnPress: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignUp()));
            },
            text:  translator.translate("sign_up"),
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomButton(
                text:  translator.translate("login"),
              ),
            ),
          ),
          InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainPage(
                          index: 0,
                        )));
              },
              child: Text( translator.translate("skip")))
        ],
      ),
    );
  }
}
