import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/UI/CustomWidgets/CustomBottomSheet.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool seeNew = false;

  bool seeConfirm = false;

  void changeNew() {
    setState(() {
      seeNew = !seeNew;
    });
    print("Status ==> ${seeNew}");
  }

  void changeConfirm() {
    setState(() {
      seeConfirm = !seeConfirm;
    });
    print("Status ==> ${seeConfirm}");
  }

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
          rowItem(Icons.lock, allTranslations.text("newPassword")),
          CustomTextField(
            suffix: InkWell(
              onTap: () {
                changeNew();
                print(seeNew);
              },
              child: seeNew == false
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
            ),
            secureText: seeNew,
            hint: "**********",
          ),
          rowItem(Icons.lock, allTranslations.text("confirm_newPassword")),
          CustomTextField(
            suffix: InkWell(
              onTap: () {
                changeConfirm();
              },
              child: seeConfirm == false
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
            ),
            secureText: seeConfirm,
            hint: "**********",
          ),
          CustomButton(
            onBtnPress: () {
              CustomSheet(
                  context: context,
                  widget: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          width: 100,
                          height: 10,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(25)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Icon(
                          Icons.check_circle,
                          size: 100,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(allTranslations.text("change_done")),
                      CustomButton(
                        text: allTranslations.text("login"),
                      ),
                    ],
                  ));
            },
            text: allTranslations.text("change"),
          )
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
