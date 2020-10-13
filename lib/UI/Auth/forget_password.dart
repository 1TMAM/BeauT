import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:flutter/material.dart';

import 'check_code.dart';
import 'login.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Image.asset(
            "assets/images/header.png",
            fit: BoxFit.cover,
            width: 100,
            height: 30,
          )),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),

        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: Icon(Icons.lock ,size: 40,color: Theme.of(context).primaryColor,),
            ),
          ),
          Center(child: Text(allTranslations.text("forget_password"))),

          rowItem(Icons.phone, allTranslations.text("phone")),
          CustomTextField(
            hint: allTranslations.text("phone"),
          ),
          SizedBox(height: 30,),
          InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => CheckCode()));
              },
              child: CustomButton(text: allTranslations.text("send"),)),
        ],
      ),
    );
  }

  Widget rowItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              text,
              style: TextStyle(fontSize: 13),
            ),
          )
        ],
      ),
    );
  }
}
