import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:flutter/material.dart';

import 'check_code.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> key = GlobalKey();

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
      body: Form(
        key: key,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Center(
                child: Icon(
                  Icons.lock,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Center(child: Text(allTranslations.text("forget_password"))),
            rowItem(Icons.mail, allTranslations.text("email")),
            CustomTextField(
              hint: "example@gmail.com",
              validate: (String val) {
                if (val.isEmpty) {
                  return " البريد الالكتروني غير صحيح";
                }
              },
              value: (String val) {},
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CheckCode()));
                },
                child: CustomButton(
                  text: allTranslations.text("send"),
                )),
          ],
        ),
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
