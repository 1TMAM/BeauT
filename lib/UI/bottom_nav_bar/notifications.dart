import 'package:buty/Bolcs/deletNotificationBloc.dart';
import 'package:buty/Bolcs/notificationBloc.dart';
import 'package:buty/UI/CustomWidgets/AppLoader.dart';
import 'package:buty/UI/CustomWidgets/EmptyItem.dart';
import 'package:buty/UI/CustomWidgets/LoadingDialog.dart';
import 'package:buty/UI/CustomWidgets/on_done_dialog.dart';
import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/NotificationResponse.dart';
import 'package:buty/models/general_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    notificationBloc.add(Hydrate());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainPage(
            index: 0,
          )));

        },
        child:Scaffold(
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
            BlocListener<NotificationBloc, AppState>(
              bloc: notificationBloc,
              listener: (context, state) {},
              child: BlocBuilder(
                bloc: notificationBloc,
                builder: (context, state) {
                  var data = state.model as NotificationResponse;
                  return data == null
                      ? AppLoader()
                      : data.notifications == null
                          ? Center(
                              child: EmptyItem(
                              text: data.msg == "الرمز المميز غير موجود"
                                  ? "عفواً يرجي تسجيل الدخول اولاًً "
                                  : data.msg == "الرمز المميز غير موجود"
                                      ? "Authorization Token Not Found"
                                      : "${data.msg}",
                            ))
                          : AnimationLimiter(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: data.notifications.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: notificationItem(
                                          data.notifications[index].beautician.beautName,
                                          data.notifications[index].title,
                                          data.notifications[index].message,
                                          data.notifications[index].id,
                                          data.notifications[index].createdAt
                                      ),
                                     
                                    ),
                                  );
                                },
                              ),
                            );
                },
              ),
            ),
          ],
        )));
  }

  Widget notificationItem(String ButyName, String title, String body, int id,String date) {
    return BlocListener(
      bloc: deleteNotificationBloc,
      listener: (context, state) {
        var data = state.model as GeneralResponse;
        if (state is Done) {
          Navigator.of(context).pop();
          onDoneDialog(context: context, text: "${data.msg}",
          function: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainPage(index: 1,)));
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      "${ButyName}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    deleteNotificationBloc.UpdateId(id);
                    deleteNotificationBloc.add(Click());
                    showLoadingDialog(context);
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "${title}",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 8,
                    child:    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child:Wrap(
                      children: [
                        Text(
                          "${body}",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ],
                    ))
                )
                ,

              ],
            ),
            Container(
              alignment: translator.currentLanguage =='ar' ? Alignment.centerLeft : Alignment.centerRight,
              child: Text(
                "${date.substring(0,16).replaceRange(10,11, '  ')}",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
