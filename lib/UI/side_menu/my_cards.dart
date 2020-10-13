import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'package:flutter/material.dart';

import 'add_new_card.dart';

class MyCards extends StatefulWidget {
  @override
  _MyCardsState createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {
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
            allTranslations.text("payment_methods"),
            style: TextStyle(color: Colors.white, fontSize: 14),
          )),
      body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          children: [
            address_item(),
            address_item(),
            CustomButton(
              onBtnPress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddNewCard()));
              },
              text: allTranslations.text("add_new_card"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10 ,vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/pay_hand.png",
                        width: 25,
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          allTranslations.text("cash_on_delivary"),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "   (${allTranslations.text("default")})   ",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.check_circle,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10 ,vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/pay_hand.png",
                        width: 25,
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Apple Pay",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.check_circle,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Divider(),
            ),
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
                Image.asset(
                  "assets/images/master_card.png",
                  width: 25,
                  height: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Karim Taha",
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
            "xxxx xxxx xxxx 8555",
            style: TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
