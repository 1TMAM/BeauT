import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'package:buty/UI/buty_details/choose_date.dart';
import 'package:buty/models/search_by_category.dart';
import 'package:flutter/material.dart';

class ButyDetails extends StatefulWidget {
  final BeauticianServices data ;

  const ButyDetails({Key key, this.data}) : super(key: key);

  @override
  _ButyDetailsState createState() => _ButyDetailsState();
}

class _ButyDetailsState extends State<ButyDetails> {
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
            "Buty Name",
            style: TextStyle(color: Colors.white, fontSize: 14),
          )),
      body: ListView(
        children: [
          Container(
            height: 150,
            color: Colors.grey[300],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "بيوتي ندي احمد ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(
                  "${allTranslations.text("services")} : ",
                ),
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.grey[200], shape: BoxShape.circle),
                  child: Center(
                    child: Image.asset(
                      "assets/images/makeup.png",
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.grey[200], shape: BoxShape.circle),
                    child: Center(
                      child: Image.asset(
                        "assets/images/hair.png",
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.grey[200], shape: BoxShape.circle),
                  child: Center(
                    child: Image.asset(
                      "assets/images/nails.png",
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${allTranslations.text("service_address")} : ",
                ),
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
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "${allTranslations.text("at_home")}",
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text("${allTranslations.text("location")}  : الرياض  "),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "${allTranslations.text("services")}  ",
            ),
          ),
          serviceRow(),
          serviceRow(),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChooseDate()));
              },
              child: CustomButton(
                text: "${allTranslations.text("choose_time")} 35 ريال",
              ))
        ],
      ),
    );
  }

  Widget serviceRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${allTranslations.text("hair")}  ",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2.1,
                child: Row(
                  children: [
                    Text(
                      "قص الشعر ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      allTranslations.text("persons"),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.add,
                          size: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            "2",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Icon(
                          Icons.remove,
                          size: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Text(
                  "تفاصيل عن خدمة قص الشعر تفاصيل عن خدمة قص الشعر تفاصيل عن خدمة قص الشعر  ",
                  style: TextStyle(fontSize: 10),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Text(
                            "35 ريال",
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            "30 دقيقة",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          allTranslations.text("reserve"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Icon(
                            Icons.check_circle_outline,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
