import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/UI/CustomWidgets/CustomBottomSheet.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:flutter/material.dart';

class Reservation extends StatefulWidget {
  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  String type = "current";

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
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      type = "current";
                    });
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          allTranslations.text("current"),
                          style: TextStyle(
                              fontWeight: type == "current"
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 4,
                          height: 2,
                          color: type == "current"
                              ? Colors.black
                              : Colors.grey[200],
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
                          allTranslations.text("last"),
                          style: TextStyle(
                              fontWeight: type == "last"
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 4,
                          height: 2,
                          color:
                              type == "last" ? Colors.black : Colors.grey[200],
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
            reservaionRow(type),
          ],
        ));
  }

  Widget reservaionRow(String type) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2.6,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("${allTranslations.text("section")} "),
                  Text(
                    " سبا ",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("${allTranslations.text("buty_name")}"),
                  Text(
                    " مي احمد  ",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("${allTranslations.text("time")} "),
                  Text(
                    " 10  Pm ",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("${allTranslations.text("date")}"),
                  Text(
                    " 28/9/2020 ",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("${allTranslations.text("details")}  "),
                  Text(
                    " هنا تكتب تفاصيل الخدمات ",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("${allTranslations.text("cost")} "),
                  Text(
                    "  50 ريال ",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  CustomSheet(context: context, widget: cansel() ,hight: MediaQuery.of(context).size.height/3.5);
                },
                child: CustomButton(
                  text: type == "current"
                      ? "${allTranslations.text("cansel")}"
                      : "${allTranslations.text("rate")}",
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[500]),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget cansel() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            allTranslations.text("validate_cansel"),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            CustomButton(
              width: MediaQuery.of(context).size.width / 2.8,
              text: allTranslations.text("yes"),
            ),
            CustomButton(
              width: MediaQuery.of(context).size.width / 2.8,
              text: allTranslations.text("no"),
              textColor: Colors.black,
              color: Colors.white,
              raduis: 1,
            ),
          ],
        )
      ],
    );
  }
}
