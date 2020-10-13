import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/UI/CustomWidgets/CustomBottomSheet.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String type = "data";

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
            allTranslations.text("edit_profile"),
            style: TextStyle(color: Colors.white, fontSize: 14),
          )),
      body: ListView(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    type = "data";
                  });
                },
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        allTranslations.text("edit_profile"),
                        style: TextStyle(
                            fontWeight: type == "data"
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: 2,
                        color: type == "data" ? Colors.black : Colors.grey[200],
                      )
                    ],
                  ),
                  width: MediaQuery.of(context).size.width / 2,
                  height: 40,
                  color: Colors.grey[200],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    type = "last";
                  });
                },
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        allTranslations.text("password"),
                        style: TextStyle(
                            fontWeight: type == "last"
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: 2,
                        color: type == "last" ? Colors.black : Colors.grey[200],
                      )
                    ],
                  ),
                  width: MediaQuery.of(context).size.width / 2,
                  height: 40,
                  color: Colors.grey[200],
                ),
              ),
            ],
          ),
          type == "data" ? editDataView() : passView(),
          CustomButton(
            onBtnPress: () {
              CustomSheet(context: context, widget: phoneVerifyCodeSheet());
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

  Widget editDataView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: rowItem(Icons.person, allTranslations.text("name")),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomTextField(
            hint: "User Name ",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: rowItem(Icons.phone, allTranslations.text("phone")),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomTextField(
            hint: "+966012545236",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: rowItem(Icons.mail, allTranslations.text("email")),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomTextField(
            hint: "example@gmail.com",
          ),
        ),
      ],
    );
  }

  Widget passView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: rowItem(Icons.lock, allTranslations.text("current_password")),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomTextField(
            secureText: true,
            hint: "*****************",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: rowItem(Icons.lock, allTranslations.text("new_password")),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomTextField(
            secureText: true,
            hint: "*****************",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child:
              rowItem(Icons.lock, allTranslations.text("confirm_new_password")),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomTextField(
            secureText: true,
            hint: "*****************",
          ),
        ),
      ],
    );
  }

  Widget phoneVerifyCodeSheet() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(),
        Text(allTranslations.text("confirm_change_phone") ,style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.bold),),
        Text(allTranslations.text("enter_code")),
        Container(
            width: double.infinity,
            height: 100,
            child: Center(
              child: PinCodeTextField(
                pinBoxWidth: 60,
                pinBoxHeight: 60,
                pinBoxColor: Colors.white,
                onDone: (String value) {},
                defaultBorderColor: Theme.of(context).primaryColor,
                pinBoxRadius: 10,
                highlightPinBoxColor: Colors.grey[50],
                hasTextBorderColor: Theme.of(context).primaryColor,
                // controller: code,
                pinTextStyle: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18),
                textDirection: TextDirection.ltr,
                keyboardType: TextInputType.phone,
              ),
            )),
        CustomButton(text: allTranslations.text("confirm"),),
        Text(allTranslations.text("resend_code")),
        SizedBox(),

      ],
    );
  }
}
