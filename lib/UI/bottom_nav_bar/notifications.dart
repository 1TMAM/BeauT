import 'package:buty/Base/AllTranslation.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Image.asset(
              "assets/images/header.png",
              fit: BoxFit.contain,
              width: 100,
              height: 30,
            )),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  allTranslations.text("notifications"),
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                Text(
                  " مسح جميع الاشعارات ",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            notificationItem(),
            notificationItem(),
            notificationItem(),
            notificationItem(),
            notificationItem(),
            notificationItem(),
            notificationItem(),
            notificationItem(),
            notificationItem(),
          ],
        ));
  }

  Widget notificationItem() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      color: Colors.grey[200], shape: BoxShape.circle),
                  child: Center(
                    child: Image.asset(
                      "assets/images/hair.png",
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
              Text(
                "اسم البيوتي",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "عنوان الاشعار",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "هنا يكتب الاشعار هنا يكتب الاشعار هنا يكتب الاشعار هنا يكتب الاشعار هنا يكتب الاشعار هنا يكتب الاشعار ",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
