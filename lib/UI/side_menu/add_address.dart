import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'package:buty/UI/side_menu/add_new_location.dart';
import 'package:flutter/material.dart';

class MyAddresses extends StatefulWidget {
  @override
  _MyAddressesState createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {
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
            allTranslations.text("my_adresses"),
            style: TextStyle(color: Colors.white, fontSize: 14),
          )),
      body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          children: [
            address_item(),
            address_item(),
            address_item(),
            address_item(),
            address_item(),
            address_item(),
            CustomButton(
              onBtnPress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddNewLocation()));
              },
              text: allTranslations.text("add_new_location"),
            )
          ]),
    );
  }

  Widget address_item() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Theme.of(context).primaryColor,
                  size: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "الرياض  - حي الرياض - السعودية",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            Text(
              allTranslations.text("edit"),
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            "تمت اضافته امس",
            style: TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
