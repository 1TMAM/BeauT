import 'package:buty/Bolcs/creat_order_bloc.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/buty_details/payment.dart';
import 'package:buty/models/my_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ChooseDate extends StatefulWidget {
  final List<MyList> servicseList;
  final int total;

  const ChooseDate({Key key, this.servicseList, this.total}) : super(key: key);

  @override
  _ChooseDateState createState() => _ChooseDateState();
}

class _ChooseDateState extends State<ChooseDate> {
  DateTime _currentDate = DateTime.now();
  CalendarCarousel _calendarCarousel;
  bool isHouse = true;

  String order_time;

  @override
  void initState() {
    createOrderBloc.updateDate(_currentDate.toString().substring(0, 10));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _calendarCarousel = CalendarCarousel<Event>(
      nextMonthDayBorderColor: Theme.of(context).primaryColor,
      prevMonthDayBorderColor: Theme.of(context).primaryColor,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate = date);
        events.forEach((event) => print(event.title));
        print(date.toString().substring(0, 10));
        createOrderBloc.updateDate(date.toString().substring(0, 10));
      },
      isScrollable: true,
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      height: 360.0,
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
    return Directionality(
      textDirection: translator.currentLanguage=="ar"?TextDirection.rtl :TextDirection.ltr,
      child: Scaffold(
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
              translator.translate("choose_time"),
              style: TextStyle(color: Colors.white, fontSize: 14),
            )),
        body: Stack(
          children: [
            ListView(
              children: [
                _calendarCarousel,
                show_time == false
                    ? OutlineButton(
                  child: Text(order_time ?? ""),
                  onPressed: () {
                    setState(() {
                      show_time = true;
                    });
                  },
                )
                    : SizedBox(),          Divider(),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.servicseList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${translator.translate("service_name")}  :  ${translator == "ar" ? widget.servicseList[index].nameAr : widget.servicseList[index].nameEn}",
                                      style: TextStyle(
                                          fontSize: 13, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${translator.translate("persons")}  :  ${widget.servicseList[index].count}  ",
                                      style: TextStyle(
                                          fontSize: 13, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${widget.servicseList[index].price} ${translator.translate("sar")}  ",
                                      style: TextStyle(
                                          fontSize: 13, fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "${widget.servicseList[index].estimatedTime} ${translator.translate("min")} ",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    translator.translate("address"),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isHouse = true;
                    });
                    createOrderBloc.updateLocationType(0);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
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
                                translator.translate("at_home"),
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
                                "130 ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            isHouse == true
                                ? Icon(
                                    Icons.check_circle,
                                    color: Theme.of(context).primaryColor,
                                    size: 25,
                                  )
                                : Icon(
                                    Icons.check_circle_outline,
                                    color: Theme.of(context).primaryColor,
                                    size: 25,
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isHouse = false;
                    });
                    createOrderBloc.updateLocationType(1);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
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
                                child: Image.asset(
                                  "assets/images/car.png",
                                  width: 25,
                                  height: 25,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                translator.translate("at_buty"),
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
                                "100 ريال",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            isHouse == false
                                ? Icon(
                                    Icons.check_circle,
                                    color: Theme.of(context).primaryColor,
                                    size: 25,
                                  )
                                : Icon(
                                    Icons.check_circle_outline,
                                    color: Theme.of(context).primaryColor,
                                    size: 25,
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                                  servicseList: widget.servicseList,
                                  address: isHouse,
                                  total: widget.total.toString(),
                                )));
                  },
                  child: CustomButton(
                    text:
                        "${translator.translate("pay_now")}  ${widget.total} ريال  ",
                  ),
                )
              ],
            ),
            show_time == true
                ? Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.9),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 120,
                  ),
                  TimePicker(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        show_time = false;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor),
                        child: Center(
                          child: Text(
                            translator.translate("done"),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  )
                ],
              ),
            )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  bool show_time = false;

  Widget TimePicker() {
    return TimePickerSpinner(
      is24HourMode: false,
      normalTextStyle: TextStyle(fontSize: 24, color: Colors.white),
      highlightedTextStyle:
      TextStyle(fontSize: 24, color: Theme.of(context).primaryColor),
      spacing: 10,
      itemHeight: 50,
      isForce2Digits: true,
      onTimeChange: (time) {
       createOrderBloc.updateTime(time.toString().substring(10 ,16));

       setState(() {
         order_time =time.toString().substring(10 ,16);
       });
        print("TIMEEEEEEEEEEE" + time.toString());
      },
    );
  }





}
