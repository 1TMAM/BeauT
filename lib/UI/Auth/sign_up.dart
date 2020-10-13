import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/UI/Auth/login.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String card_num = "123456789";

  String cardHolder = "Enter your Name";

  String cvv = "1234";

  bool showVisa = false;

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
          rowItem(Icons.person, allTranslations.text("name")),
          CustomTextField(
            hint: allTranslations.text("write_name"),
          ),
          rowItem(Icons.phone, allTranslations.text("phone")),
          CustomTextField(
            hint: "+966210025500",
          ),
          rowItem(Icons.mail, allTranslations.text("email")),
          CustomTextField(
            hint: "example@gmail.com",
          ),
          rowItem(Icons.location_on, allTranslations.text("address")),
          CustomTextField(
            hint: allTranslations.text("write_address"),
          ),
          rowItem(Icons.lock, allTranslations.text("password")),
          CustomTextField(
            hint: "************",
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    allTranslations.text("add_depet_card"),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      allTranslations.text("default"),
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
              showVisa == false
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          showVisa = true;
                        });
                      },
                      child: Icon(Icons.keyboard_arrow_up))
                  : InkWell(
                      onTap: () {
                        setState(() {
                          showVisa = false;
                        });
                      },
                      child: Icon(Icons.keyboard_arrow_down)),
            ],
          ),
          showVisa == false ? Visa() : SizedBox(),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainPage(
                            index: 0,
                          )));
            },
            child: CustomButton(
              text: allTranslations.text("register"),
            ),
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Center(child: Text(allTranslations.text("have_acc")))),
        ],
      ),
    );
  }

  Widget Visa() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(allTranslations.text("card_number")),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomTextField(
            hint: card_num,
            inputType: TextInputType.number,
            value: (String val) {
              setState(() {
                card_num = val;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(allTranslations.text("expireDate")),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Theme.of(context).primaryColor)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(DateTime.now().toString().substring(0, 10)),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("CVV"),
                      SizedBox(
                        width: 120,
                      ),
                    ],
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: CustomTextField(
                        hint: "CVV",
                        inputType: TextInputType.number,
                        value: (String val) {
                          setState(() {
                            cvv = val;
                          });
                        },
                      )),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(allTranslations.text("card_holder")),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomTextField(
            hint: "User Name",
            value: (String val) {
              setState(() {
                cardHolder = val;
              });
            },
          ),
        ),
      ],
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
