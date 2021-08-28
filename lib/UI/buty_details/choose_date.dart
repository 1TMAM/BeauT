import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/Base/shared_preference_manger.dart';
import 'package:buty/Bolcs/creat_order_bloc.dart';
import 'package:buty/Bolcs/payment_bloc.dart';
import 'package:buty/UI/CustomWidgets/AppLoader.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/ErrorDialog.dart';
import 'package:buty/UI/CustomWidgets/on_done_dialog.dart';
import 'package:buty/UI/buty_details/payment.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/Payment/beautician_avaliable_time_model.dart';
import 'package:buty/models/my_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart' as intl;

class ChooseDate extends StatefulWidget {
  final List<MyList> servicseList;
  final int total;

  const ChooseDate({Key key, this.servicseList, this.total}) : super(key: key);

  @override
  _ChooseDateState createState() => _ChooseDateState();
}

class _ChooseDateState extends State<ChooseDate> with TickerProviderStateMixin{
  DateTime _currentDate = DateTime.now();
  CalendarCarousel _calendarCarousel;
  CalendarController _calendarController;
  AnimationController _animationController;
  String datee;
  bool isHouse = true;

  String order_time;
  var total_cost;
  @override
  void initState() {
    payment_bloc.add(BeauticianTimesEvent());
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _calendarController = CalendarController();
    createOrderBloc.updateDate(_currentDate.toString().substring(0, 10));
    total_cost = widget.total+130;
    super.initState();
  }
  int _selectedIndex;
  _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });

    print("widget.servicseList : ${widget.servicseList}");
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _calendarController.dispose();

    super.dispose();
    total_cost =0;
  }
  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: translator.currentLanguage == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              Padding(padding: EdgeInsets.only(right: 10,left: 10),
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);

                    },
                    child:  Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    )),)
            ],
            centerTitle: true,
            title: Text(
              translator.translate("choose_time"),
              style: TextStyle(color: Colors.white, fontSize: 14),
            )),
        body: Stack(
          children: [
            ListView(
              children: [
                //   _calendarCarousel,
                _buildTableCalendar(),
                Container(
                    height: 40,
                    child: BlocBuilder(
                      bloc: payment_bloc,
                      builder: (context,state){
                        if(state is Loading){
                          if(state.indicator == 'beautician_time'){
                            return AppLoader();
                          }
                        }else if(state is Done){
                          if(state.indicator == 'beautician_time'){
                            return StreamBuilder<BeauticianAvaliableTimeModel>(
                                stream: payment_bloc.subject,
                                builder: (context , snapshot){
                                  if(snapshot.hasData){
                                    if(snapshot.data.data.isEmpty){
                                      return Container();
                                    }else{
                                      return ListView.builder(
                                          itemCount: snapshot.data.data.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: (){
                                                _onSelected(index);
                                                createOrderBloc.updateTime(snapshot.data.data[index]);
                                                sharedPreferenceManager.writeData(CachingKey.RESERVATION_TIME, snapshot.data.data[index]);
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
                                                        snapshot.data.data[index],
                                                        textDirection: TextDirection.ltr,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    }
                                  }else if (snapshot.hasError) {
                                    return Container(
                                      child: Text('${snapshot.error}'),
                                    );
                                  } else {
                                    return AppLoader();
                                    ;
                                  }
                                }
                            );
                          }
                        }else if (state is ErrorLoading) {
                          return Container(
                          );
                        } else {
                          return AppLoader();
                        }
                      },
                    )
                ),
                Divider(),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.servicseList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                if (widget.servicseList.isEmpty) {
                                  Navigator.pop(context);
                                } else {
                                  setState(() {
                                    print("service-price : ${widget.servicseList[index].price}");
                                    print('totalcost : ${total_cost}');
                                    total_cost = total_cost - int.parse(widget.servicseList[index].price);
                                    widget.servicseList.removeAt(index);

                                  });
                                }
                              },
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.close,color: Colors.red,),
                                  SizedBox(),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${translator.translate("service_name")}  :  ${ widget.servicseList[index].nameAr}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${translator.translate("persons")}  :  ${widget.servicseList[index].count}  ",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${widget.servicseList[index].price} ${translator.translate("sar")}  ",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
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
                      total_cost = widget.total + 130 ;
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
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.width * 0.15,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  shape: BoxShape.circle),
                              child: Center(
                                child: Image.asset(
                                  "assets/images/home.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
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
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "130 SAR",
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
                      total_cost = widget.total + 100;
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
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.width * 0.15,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  shape: BoxShape.circle),
                              child: Center(
                                child: Image.asset(
                                  "assets/images/beaut_location.png",
                                  fit:  BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
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
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "100 ${translator.translate("sar")}",
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
                    print("@@@@total_cost : ${total_cost}");
                    widget.servicseList.isEmpty? errorDialog(
                      context: context,
                      text: translator.translate("services_list"),
                    ):   createOrderBloc.time.value ==null ? errorDialog(
                      context: context,
                      text: translator.translate( "you must choose date and time for your order"),
                    ): Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                              servicseList: widget.servicseList,
                              address: isHouse,
                              total: total_cost.toString(),
                            )));
                    //   total_cost=0;
                  },
                  child: CustomButton(
                    text:
                    "${translator.translate("pay_now")}  ${total_cost} ريال  ",

                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool show_time = false;


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
        //  selectedColor: Theme.of(context).primaryColor,
          selectedColor: Color(0xFFDBB2D2),
          selectedStyle: TextStyle(color:Color(0xFFDBB2D2),fontSize: 16 ),
          highlightSelected: true,
          outsideDaysVisible: false,
          weekendStyle: TextStyle(color: Colors.black),
          holidayStyle: TextStyle(color: Color(0xFFBABDC3))),
      headerStyle:
      HeaderStyle(formatButtonVisible: false, centerHeaderTitle: true),
      onDaySelected: (date, events, holidays) {
        String date_formatted;
        setState(() {
          final intl.DateFormat formatter = intl.DateFormat('dd-MM-yyyy');
            date_formatted = formatter.format(date);
          createOrderBloc.updateDate(date_formatted);
          sharedPreferenceManager.writeData(CachingKey.RESERVATION_DATE, date_formatted);
          payment_bloc.add(BeauticianTimesEvent());
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
