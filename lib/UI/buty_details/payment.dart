import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/UI/CustomWidgets/CustomBottomSheet.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'file:///C:/Users/taiko/AndroidStudioProjects/buty/lib/UI/side_menu/cards/add_new_card.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          centerTitle: true,
          title: Text(
            allTranslations.text("payment"),
            style: TextStyle(color: Colors.white, fontSize: 14),
          )),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "قص شعر   x 2 ",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  Text(
                    "35 ريال  ",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "30 min ",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                " استشوار x2  ",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  Text(
                    "35 ريال  ",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    "30 min ",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
          Text(
            allTranslations.text("address"),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.grey[200], shape: BoxShape.circle),
                    child: Center(
                      child: Icon(
                        Icons.home,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      allTranslations.text("at_home"),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "130 ريال",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                allTranslations.text("copoun"),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 50,
                child: Center(
                  child: Text(allTranslations.text("enter_copoun")),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey[200])),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                allTranslations.text("duration"),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Center(
                child: Text("60 min"),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                allTranslations.text("date"),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Center(
                child: Text("${DateTime.now().toString().substring(0, 10)}"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                allTranslations.text("time"),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Center(
                child: Text("10 Pm"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                allTranslations.text("total"),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Center(
                child: Text("60 ريال"),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                allTranslations.text("pay_method"),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(allTranslations.text("cash_on_delivary")),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text("ApplePay"),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text("Credit Card"),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              CustomSheet(
                  context: context,
                  widget: Column(
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

                    ],
                  ));
            },
            child: CustomButton(
              text: allTranslations.text("pay_now"),
            ),
          )
        ],
      ),
    );
  }

  Widget address_item() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
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
              Icon(
                Icons.check_circle_outline,
                color: Theme.of(context).primaryColor,
              )
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
      ),
    );
  }
}
