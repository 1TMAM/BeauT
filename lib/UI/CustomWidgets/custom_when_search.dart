import 'dart:convert';

import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/Base/old_netWork.dart';
import 'package:buty/Base/shared_preference_manger.dart';
import 'package:buty/Bolcs/creat_order_bloc.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/ErrorDialog.dart';
import 'package:buty/UI/CustomWidgets/LoadingDialog.dart';
import 'package:buty/UI/CustomWidgets/static_data.dart';
import 'package:buty/UI/CustomWidgets/static_data.dart';
import 'package:buty/UI/bottom_nav_bar/hom_page.dart';
import 'package:buty/UI/bottom_nav_bar/searchBytime_results.dart';
import 'package:buty/models/providers_response.dart';
import 'package:buty/models/search_by_category.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart' as intl;

class CustomWhenSearch extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomWhenSearchState();
  }

}

class CustomWhenSearchState extends State<CustomWhenSearch> with TickerProviderStateMixin{
  CalendarCarousel _calendarCarousel;
  var when_date;
  var when_time;
  CalendarController _calendarController;
  AnimationController _animationController;

  String datee;
  OldNetworkUtil _util = OldNetworkUtil();
  SearchResultResponse resultRess = SearchResultResponse();

  DateTime _currentDate = DateTime.now();
  int _selectedIndex;
  _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    createOrderBloc.updateDate(_currentDate.toString().substring(0, 10));
    _calendarController = CalendarController();
    super.initState();
  }

  List<String> timeList = [
    "10:00 AM", "10:30 AM", "11:00 AM", "11:30 AM", "12:00 PM", "12:30 PM", "01:00 PM", "01:30 PM", "02:00 PM", "02:30 PM", "03:00 PM", "03:30 PM", "04:00 PM", "04:30 PM",
    "05:00 PM", "05:30 PM", "06:00 PM", "06:30 PM", "07:00 PM", "07:30 PM", "08:00 PM", "08:30 PM", "09:00 PM", "09:30 PM", "10:00 PM",
    "10:30 PM", "11:00 PM", "11:30 PM"
  ];
  void searchByTime(String time , String date) async {
    print("search date :${date}");
    print("search time :${time}");
    showLoadingDialog(context);
    print("In Time Service");

    Response response = await _util.get(
        "users/search/search-beautician-time?time=$time&date=${date}"
    );
    print("STATUS CODE =========> ${response.statusCode}");
    print("RESPONSE =========> ${response}");
    if (response.data["status"] == true) {
      print("Donee");
      setState(() {
        StaticData.data.clear();
        print("before StaticData.data : ${StaticData.data}");
        resultRess = SearchResultResponse.fromJson(json.decode(response.toString()));
        print("resultRess : ${resultRess}");
        StaticData.data.addAll(resultRess.data.beauticianServices);
        print("when StaticData.data : ${StaticData.data}");
        Navigator.pop(context);
   /*     StaticData.providers_searh_when.addAll(resultRess.data.beauticianServices);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SearchByTimeResults(
          data: StaticData.providers_searh_when,
        )));*/

      });
    } else {
      Navigator.pop(context);
      errorDialog(context: context, text: response.data["msg"]);
      print("Error");
    }
  }


  @override
  Widget build(BuildContext context) {

   return StatefulBuilder(
      builder: (context, setState) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return Container(
          width: width,
          height: height / 1.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height*.1)
          ),
          child: AlertDialog(
            contentPadding: EdgeInsets.all(0.0),
            content:  SafeArea(
              child: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    width: width,
                  //  height: height / 1.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.1)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.1),
                      child: Column(
                        children: [
                          SizedBox(height:10,),
                          //  _calendarCarousel,
                          _buildTableCalendar(),
                          SizedBox(height: 10,),
                          Container(
                              height:  MediaQuery.of(context).size.width/7,
                              child: ListView.builder(
                                  itemCount: timeList.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: (){
                                        _onSelected(index);
                                        createOrderBloc.updateTime(timeList[index]);
                                        when_time = timeList[index];
                                        StaticData.when_value = when_time;
                                        print("time----- : ${timeList[index]}");
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: _selectedIndex ==index ? Color(0xFFDBB2D2) : Colors.grey.shade200,
                                          ),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: Text(
                                                timeList[index],
                                                textDirection: TextDirection.ltr,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })),
                          SizedBox(height: MediaQuery.of(context).size.width/7,),
                          CustomButton(
                            text: 'بحث',
                            onBtnPress: (){
                              print("when_time : ${when_time}");
                              print("when_date : ${when_date}");

                              searchByTime(when_time,when_date);
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

        );
      },
    );

    // TODO: implement build
  /*  return   Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.1),
        child: Column(
          children: [
            SizedBox(height:10,),
            //  _calendarCarousel,
            _buildTableCalendar(),
            SizedBox(height: 10,),
            Container(
                height:  MediaQuery.of(context).size.width/7,
                child: ListView.builder(
                    itemCount: timeList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          _onSelected(index);
                          createOrderBloc.updateTime(timeList[index]);
                          when_time = timeList[index];
                          StaticData.when_value = when_time;
                          print("time----- : ${timeList[index]}");
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _selectedIndex ==index ? Color(0xFFDBB2D2) : Colors.grey.shade200,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20),
                                child: Text(
                                  timeList[index],
                                  textDirection: TextDirection.ltr,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
            SizedBox(height: MediaQuery.of(context).size.width/7,),
            CustomButton(
              text: 'بحث',
              onBtnPress: (){
                print("when_time : ${when_time}");
                print("when_date : ${when_date}");

                searchByTime(when_time,when_date);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );*/
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      //startDay: DateTime.now(),
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
        setState(() {
          datee = date.toString().substring(0, 10);
          final intl.DateFormat formatter = intl.DateFormat('dd-MM-yyyy');
          when_date = formatter.format(date);
          print("-----when_date ------- : ${when_date}");
        });
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