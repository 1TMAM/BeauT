import 'dart:convert';

import 'package:buty/Base/old_netWork.dart';
import 'package:buty/Bolcs/creat_order_bloc.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/ErrorDialog.dart';
import 'package:buty/UI/CustomWidgets/LoadingDialog.dart';
import 'package:buty/UI/CustomWidgets/static_data.dart';
import 'package:buty/UI/CustomWidgets/static_data.dart';
import 'package:buty/UI/bottom_nav_bar/hom_page.dart';
import 'package:buty/models/providers_response.dart';
import 'package:buty/models/search_by_category.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class CustomWhenSearch extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomWhenSearchState();
  }

}

class CustomWhenSearchState extends State<CustomWhenSearch>{
  CalendarCarousel _calendarCarousel;
  var when_date;
  var when_time;
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
  void initState() {
    createOrderBloc.updateDate(_currentDate.toString().substring(0, 10));

    super.initState();
  }

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
  void searchByTime(String time , String date) async {
    showLoadingDialog(context);
    print("In Time Service");
    print("time : ${time}");
    print("date : ${date}");

    Response response = await _util.get(
      // "users/search/key-search?value_name=$id&key=time",
        "users/search/search-beautician-time?time=$time&date=${date}"
    );
    print("STATUS CODE =========> ${response.statusCode}");
    print("RESPONSE =========> ${response}");
    if (response.data["status"] == true) {
      print("Donee");
      setState(() {
        resultRess =
            SearchResultResponse.fromJson(json.decode(response.toString()));
       // data.addAll(resultRess.data.beauticianServices);
        StaticData.data.addAll(resultRess.data.beauticianServices);
        Navigator.pop(context);
      });
    } else {
      Navigator.pop(context);
      errorDialog(context: context, text: response.data["msg"]);
      print("Error");
    }
  }


  @override
  Widget build(BuildContext context) {
    _calendarCarousel = CalendarCarousel<Event>(
      nextMonthDayBorderColor: Theme.of(context).primaryColor,
      prevMonthDayBorderColor: Theme.of(context).primaryColor,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate = date);
        events.forEach((event) => print(event.title));
        when_date = date.toString().substring(0, 10);
        print(date.toString().substring(0, 10));
        createOrderBloc.updateDate(date.toString().substring(0, 10));
      },
      isScrollable: true,
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      height: MediaQuery.of(context).size.width,
      selectedDateTime: _currentDate,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      selectedDayTextStyle: TextStyle(
        color: Colors.white,
      ),
      todayTextStyle: TextStyle(
        color: Colors.white,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      todayButtonColor: Theme.of(context).primaryColor,
      todayBorderColor: Theme.of(context).primaryColor,
    );

    // TODO: implement build
    return   Column(
      children: [
        SizedBox(height:10,),
        _calendarCarousel,
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
            searchByTime(when_time,when_date);
            Navigator.pop(context);
          },
        )
      ],
    );
  }


}