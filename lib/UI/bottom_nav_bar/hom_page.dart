import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:buty/UI/buty_details/buty_details.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: CustomTextField(
                        hint: allTranslations.text("search"),
                        icon: Icon(Icons.search),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(allTranslations.text("where")),
                            )),
                      ),
                      Card(
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(allTranslations.text("when")),
                            )),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3.3,
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            child: Center(
                              child: Image.asset(
                                "assets/images/makeup.png",
                                width: 50,
                                height: 50,
                              ),
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          ),
                          Text(
                            allTranslations.text("makeup"),
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3.3,
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            child: Center(
                              child: Image.asset(
                                "assets/images/hair.png",
                                width: 50,
                                height: 50,
                              ),
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          ),
                          Text(
                            allTranslations.text("hair"),
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3.3,
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            child: Center(
                              child: Image.asset(
                                "assets/images/nails.png",
                                width: 50,
                                height: 50,
                              ),
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          ),
                          Text(
                            allTranslations.text("nails"),
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${allTranslations.text("makeup")} (110)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          itemCard(),
          itemCard(),
          itemCard(),
          itemCard(),
          itemCard(),
        ],
      ),
    );
  }

  Widget itemCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ButyDetails()));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              color: Colors.grey[300],
            ),
            Text(
              "بيوتي ندي احمد ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
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
            SizedBox(
              height: 20,
            ),
            Row(
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
          ],
        ),
      ),
    );
  }
}
