import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/Bolcs/search_by_time_bloc.dart';
import 'package:buty/UI/CustomWidgets/ErrorDialog.dart';
import 'package:buty/UI/CustomWidgets/LoadingDialog.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/search_by_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:table_calendar/table_calendar.dart';

import '../SearchResult.dart';

class SearchByTime extends StatefulWidget {
  @override
  _SearchByTimeState createState() => _SearchByTimeState();
}

class _SearchByTimeState extends State<SearchByTime>
    with TickerProviderStateMixin {
  CalendarController _calendarController;
  AnimationController _animationController;
  List<Days> days = [];

  List<String> timeList = [
    "10 : 00",
    "10 : 30",
    "11 : 00",
    "11 : 30",
    "12 : 00",
    "12 : 30",
    "01 : 00",
    "01 : 30",
    "02 : 00",
    "02 : 30",
    "03 : 00",
    "03 : 30",
    "04 : 00",
    "04 : 30",
    "05 : 00",
    "05 : 30",
    "06 : 00",
    "06 : 30",
    "07 : 00",
    "07 : 30",
    "08 : 00",
    "08 : 30",
    "09 : 00",
    "09 : 30",
  ];

  @override
  void initState() {
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    days = [
      Days(
          id: 1,
          name: allTranslations.currentLanguage == "ar" ? "السبت" : "Saturday",
          isSellected: false),
      Days(
          id: 2,
          name: allTranslations.currentLanguage == "ar" ? "الاحد" : "Sunday",
          isSellected: false),
      Days(
          id: 3,
          name: allTranslations.currentLanguage == "ar" ? "الاثنين" : "Monday",
          isSellected: false),
      Days(
          id: 4,
          name:
              allTranslations.currentLanguage == "ar" ? "الثلاثاء" : "Tuesday",
          isSellected: false),
      Days(
          id: 5,
          name: allTranslations.currentLanguage == "ar"
              ? "الاربعاء"
              : "Wednesday",
          isSellected: false),
      Days(
          id: 6,
          name: allTranslations.currentLanguage == "ar" ? "الخميس" : "Thursday",
          isSellected: false),
      Days(
          id: 7,
          name: allTranslations.currentLanguage == "ar" ? "الجمعة" : "Friday",
          isSellected: false),
    ];

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(("${translator.translate("when")}")),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        children: [
          _buildTableCalendar(),
          BlocListener(
            bloc: searchByTimeBloc,
            listener: (context, state) {
              var data = state.model as SearchByCategoryResponse;
              if (state is Loading) showLoadingDialog(context);
              if (state is ErrorLoading) {
                Navigator.of(context).pop();
                errorDialog(
                  context: context,
                  text: data.msg,
                );
              }
              if (state is Done) {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchResult(
                              beauticianServices:
                                  data.data.beauticianServices == null
                                      ? null
                                      : data.data.beauticianServices,
                            )));
              }
            },
            child: Container(
              height: 60,
              child: ListView.builder(
                  itemCount: timeList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: InkWell(
                        onTap: () {
                          print(timeList[index]);
                          searchByTimeBloc.updateId(timeList[index]);
                          searchByTimeBloc.add(Click());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  child: Text(
                                    "${timeList[index]}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                )),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      startDay: DateTime.now(),
      calendarController: _calendarController,
      locale: allTranslations.currentLanguage,
      daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle(color: Color(0xFFBABDC3), fontSize: 12),
          weekdayStyle: TextStyle(color: Color(0xFFBABDC3), fontSize: 12)),
      startingDayOfWeek: StartingDayOfWeek.saturday,
      onUnavailableDaySelected: () {
        print("ssss");
      },
      calendarStyle: CalendarStyle(
          highlightToday: false,
          selectedColor: Theme.of(context).primaryColor,
          outsideDaysVisible: false,
          weekendStyle: TextStyle(color: Colors.black),
          holidayStyle: TextStyle(color: Color(0xFFBABDC3))),
      headerStyle:
          HeaderStyle(formatButtonVisible: false, centerHeaderTitle: true),
      onDaySelected: (date, events, holidays) {
        print(date);
      },
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.only(top: 3),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  '${date.day}',
                  style:
                      TextStyle(color: Colors.white).copyWith(fontSize: 16.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Days {
  int id;
  String name;
  bool isSellected;

  Days({this.id, this.name, this.isSellected});

  Days.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isSellected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
