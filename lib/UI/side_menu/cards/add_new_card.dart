import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/UI/CustomWidgets/CustomBottomSheet.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'file:///C:/Users/taiko/AndroidStudioProjects/buty/lib/UI/side_menu/cards/my_cards.dart';
import 'package:flutter/material.dart';

class AddNewCard extends StatefulWidget {
  @override
  _AddNewCardState createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  String card_num = "123456789";

  String cardHolder = "Enter your Name";

  String cvv = "1234";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
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
            allTranslations.text("add_new_card"),
            style: TextStyle(color: Colors.white, fontSize: 14),
          )),
      body: ListView(
        children: [
          exampleContainer(),
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
                          child:
                              Text(DateTime.now().toString().substring(0, 10)),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("CVV"),
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
          InkWell(
              onTap: () {
                CustomSheet(
                    context: context,
                    widget: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            width: 60,
                            height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        Text(allTranslations.text("done_add_card")),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Icon(
                            Icons.check_circle,
                            size: 125,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyCards()));
                          },
                          child: CustomButton(
                            text: allTranslations.text("back"),
                          ),
                        )
                      ],
                    ));
              },
              child: CustomButton(
                text: "${allTranslations.text("add")}",
              )),

        ],
      ),
    );
  }

  Widget exampleContainer() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Card(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(card_num),
                      Image.asset(
                        "assets/images/master_card.png",
                        width: 25,
                        height: 25,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("CVV"),
                      Text("Expire Date"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(cvv),
                      Text("${DateTime.now().toString().substring(0, 10)}"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(cardHolder),
              ],
            ),
          ),
        ),
      ),
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
    );
  }
}
