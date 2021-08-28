import 'dart:convert';

import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/Base/old_netWork.dart';
import 'package:buty/Base/shared_preference_manger.dart';
import 'package:buty/Bolcs/creat_order_bloc.dart';
import 'package:buty/Bolcs/get_category_bloc.dart';
import 'package:buty/UI/CustomWidgets/AppLoader.dart';
import 'package:buty/UI/CustomWidgets/CustomBottomSheet.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/ErrorDialog.dart';
import 'package:buty/UI/CustomWidgets/LoadingDialog.dart';
import 'package:buty/UI/CustomWidgets/custom_when_search.dart';
import 'package:buty/UI/CustomWidgets/static_data.dart';
import 'package:buty/UI/SearchResult.dart';
import 'package:buty/UI/component/single_provider_item_row.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/categories_response.dart';
import 'package:buty/models/cites_response.dart';
import 'package:buty/models/providers_response.dart';
import 'package:buty/models/search_by_category.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart' as intl;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TextEditingController search_controller = new TextEditingController();
  AnimationController _animationController;
  var when_date;
  var when_time;
  var search_keyword = '';
  bool frist_time_search;
  DateTime _currentDate = DateTime.now();

  ProvidersResponse allProviders = ProvidersResponse();
  CitiesResponse allCities = CitiesResponse();
  List<AllButicans> searshResult = [];
  OldNetworkUtil _util = OldNetworkUtil();
  bool isLoading = true;
  String time = null;
  String where_value;
  String when_value;
  bool category_status;
  SearchResultResponse resultRess = SearchResultResponse();
  CalendarCarousel _calendarCarousel;
  CalendarController _calendarController;

  String datee;
  String category_name = '';
  int countBeautician = 0;
  int _selectedIndex;
  int category_id;
  _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _calendarController = CalendarController();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    getFromCash();
    getCategoriesBloc.add(Hydrate());
    getHomeData();
    getAllCities();
    createOrderBloc.updateDate(_currentDate.toString().substring(0, 10));
    category_status = false;
    frist_time_search = true;
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();

    sharedPreferenceManager.removeData(CachingKey.WHEN_DATE);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(right:10.0,left: 10,top: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
                child: TextField(
                  textDirection: translator.currentLanguage == 'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  controller: search_controller,
                  textAlign: translator.currentLanguage == 'ar'
                      ? TextAlign.start
                      : TextAlign.end,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText:
                        "${translator.translate("search by artist name")}",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    border: InputBorder.none,
                    prefixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          search_keyword = search_controller.text;
                        });
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            automaticallyImplyLeading: false,
            elevation: 0,
          ),
          body: Directionality(
            textDirection: translator.currentLanguage == 'ar'
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: ListView(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.05,
                          bottom: MediaQuery.of(context).size.width * 0.05,
                          left: MediaQuery.of(context).size.width * 0.06,
                          right: MediaQuery.of(context).size.width * 0.06,
                        ),
                        child:  Directionality(
                          textDirection: translator.currentLanguage == 'ar'
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //----------------------------------- search by  where -----------------------------------
                            Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    CustomSheet(
                                        context: context,
                                        widget: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  CustomSheet(
                                                      context: context,
                                                      hight:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              3,
                                                      widget: ListView.builder(
                                                          itemCount: allCities
                                                              .cities.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  where_value =
                                                                      allCities
                                                                          .cities[
                                                                              index]
                                                                          .nameEn;
                                                                });

                                                                searchByCities(allCities.cities[index]
                                                                        .id);
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "${allCities.cities[index].nameEn}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                  Divider(),
                                                                ],
                                                              ),
                                                            );
                                                          }));
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              3,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor)),
                                                      child: Image.asset(
                                                          "assets/images/beaut_location.png"),
                                                    ),
                                                    Text(translator
                                                        .translate("at_buty")),
                                                  ],
                                                )),
                                            InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  CustomSheet(
                                                      context: context,
                                                      hight:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              3,
                                                      widget: ListView.builder(
                                                          itemCount: allCities
                                                              .cities.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return InkWell(
                                                              onTap: () {
                                                                searchByCities(allCities.cities[index].id);

                                                                setState(() {
                                                                  where_value = allCities.cities[index].nameEn;
                                                                });
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    "${allCities.cities[index].nameEn}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                  Divider(),
                                                                ],
                                                              ),
                                                            );
                                                          }));
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2.2,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            3,
                                                        child: Image.asset(
                                                          "assets/images/home.png",
                                                        )),
                                                    Text(translator
                                                        .translate("at_home")),
                                                  ],
                                                )),
                                          ],
                                        ));
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.6,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 1),
                                      child: Row(
                                        mainAxisAlignment: where_value ==null?MainAxisAlignment.center : MainAxisAlignment.start,

                                        children: [
                                          Icon(
                                            Icons.add_location,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            where_value ??
                                                translator.translate("where"),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                 left: translator.currentLanguage == 'ar' ? 0 : MediaQuery.of(context).size.width * 0.3 ,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        where_value = null;
                                        StaticData.data.clear();
                                        StaticData.data = StaticData.providers_list;
                                        frist_time_search = true;
                                      });
                                    },
                                    child: where_value == null
                                        ? Container()
                                        : Icon(
                                            Icons.close,
                                            color: Colors.black,
                                            size: 25,
                                          ),
                                  ),
                                )
                              ],
                            ),

                            SizedBox(
                              width: 10,
                            ),

                            //----------------------------------- search by  when -----------------------------------

                            Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    //timeDialog();
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              var height = MediaQuery.of(context).size.height;
                                              var width = MediaQuery.of(context).size.width;
                                              return Container(
                                                width: width,
                                                height: height / 1.5,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            height * .1)),
                                                child: AlertDialog(
                                                  contentPadding: EdgeInsets.all(0.0),
                                                  content: SafeArea(
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Directionality(
                                                        textDirection: TextDirection.rtl,
                                                        child: Container(
                                                          width: width,
                                                          //  height: height / 1.5,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          width *
                                                                              0.1)),
                                                          child: Padding(
                                                            padding: EdgeInsets.only(
                                                                top: MediaQuery.of(context).size.width * 0.01),
                                                            child: Column(
                                                              children: [
                                                              InkWell(
                                                                onTap:(){
                                                            Navigator.pop(context);
                                                          },
                                                                child:   Container(
                                                                  child: Icon(Icons.close),
                                                                  alignment: Alignment.centerLeft,
                                                                  padding: EdgeInsets.all(5),
                                                                ),
                                                              ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                //  _calendarCarousel,
                                                                _buildTableCalendar(),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Container(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        9,
                                                                    child: ListView.builder(
                                                                        itemCount: timeList.length,
                                                                        scrollDirection: Axis.horizontal,
                                                                        itemBuilder: (context, index) {
                                                                          return InkWell(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                _onSelected(index);
                                                                                createOrderBloc.updateTime(timeList[index]);
                                                                                when_time = timeList[index];
                                                                                StaticData.when_value = when_time;
                                                                              });
                                                                            },
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 5,),
                                                                              child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                  color: _selectedIndex == index ? Color(0xFFDBB2D2) : Colors.grey.shade200,
                                                                                ),
                                                                                child: Center(
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.symmetric(horizontal: 5,),
                                                                                    child: Text(
                                                                                      timeList[index],
                                                                                      textDirection: TextDirection.ltr,
                                                                                      style: TextStyle(fontSize: 12),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        })),
                                                                SizedBox(
                                                                  height: MediaQuery.of(context).size.width /9,
                                                                ),
                                                                CustomButton(
                                                                  text: 'بحث',
                                                                  onBtnPress:
                                                                      () {
                                                                    searchByTime(
                                                                        when_time,
                                                                        when_date);
                                                                    Navigator.pop(
                                                                        context);
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
                                        });
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.6,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 1),
                                          child: Row(
                                            mainAxisAlignment: when_date ==null?MainAxisAlignment.center : MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.timer,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                when_date ??
                                                    translator
                                                        .translate("when"),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                                Positioned(
                                    left: translator.currentLanguage == 'ar' ? 0 : MediaQuery.of(context).size.width * 0.3 ,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          when_date = null;
                                          StaticData.data.clear();
                                          StaticData.providers_searh_when
                                              .forEach((element) {
                                            StaticData.data.add(element);
                                          });
                                        });
                                      },
                                      child: when_date == null
                                          ? Container()
                                          : Icon(
                                              Icons.close,
                                              color: Colors.black,
                                              size: 25,
                                            ),
                                    ))
                              ],
                            ),
                          ],
                        ),)
                      ),

                      // ----------------------- categories ----------------------------

                      BlocListener<GetCategoriesBloc, AppState>(
                        bloc: getCategoriesBloc,
                        listener: (context, state) {},
                        child: BlocBuilder(
                          bloc: getCategoriesBloc,
                          builder: (context, state) {

                            var data = state.model as CategoriesResponse;
                            return data == null
                                ? AppLoader()
                                : data.categories == null
                                    ? Center(
                                        child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        child: Text(
                                          data.msg == "الرمز المميز غير موجود"
                                              ? "عفواً يرجي تسجيل الدخول اولاًً "
                                              : data.msg ==
                                                      "الرمز المميز غير موجود"
                                                  ? "Authorization Token Not Found"
                                                  : "Sorry You Must Log In First",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ))
                                    : AnimationLimiter(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: data.categories.length,
                                            itemBuilder: (BuildContext context, int index) {
                                              return  AnimationConfiguration
                                                  .staggeredList(
                                                position: index,
                                                duration: const Duration(
                                                    milliseconds: 375),
                                                child: SlideAnimation(
                                                  verticalOffset: 50.0,
                                                  child: FadeInAnimation(
                                                    child:
                                                        cat_item(
                                                            image: data.categories[index].icon,
                                                            name: translator.currentLanguage == "ar" ? data.categories[index].nameAr
                                                                : data.categories[index].nameEn,
                                                            id: data.categories[index].id,
                                                            cat_count: data
                                                                .categories[index].beauticians_count //set cat_count--------------------------------------------
                                                        ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                countBeautician==0? Container() : Padding(padding: EdgeInsets.only(right: 10,left: 10,top: 10),
                  child: Row(
                    children: [
                      Text(category_name,style:
                      TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                      Text(countBeautician==0? "" : " ( ${countBeautician} )",style:
                      TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),

                    ],
                  ),) ,

                isLoading == true
                    ? AppLoader()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: StaticData.data.length,
                                itemBuilder: (context, index) {
                                return StaticData.data[index].ownerName
                                          .contains(search_keyword)
                                      ? Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child:  SingleProviderItemRow(
                                            beautic: StaticData.data[index],
                                          ),
                                        )
                                      : Container() ;
                                })
                          ],
                        ),
                      ),
              ],
            ),
          ),
        )));
  }

  Widget cat_item({String image, String name, int id, int cat_count}) {
    return InkWell(
      onTap: () {
        setState(() {
          category_status = true;
          category_id = id;
          category_name = name;
        });
        searchByCategoryId(id, name);
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width / 4.5,
              width: MediaQuery.of(context).size.width / 4,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.cover)),
            ),
            Text(
              name,
              style: TextStyle(color: Colors.white),
            ),

          ],
        ),
      ),
    );
  }

  void getHomeData() async {
    var mSharedPreferenceManager = SharedPreferenceManager();

    Response response = await _util.get(
      "user/provider/get-all-provider?lang=${translator.currentLanguage}&latitude=${await mSharedPreferenceManager.readDouble(CachingKey.USER_LAT)}"
      "&longitude=${await mSharedPreferenceManager.readDouble(CachingKey.USER_LONG)}",
    );
    if (response.data["status"] == true) {
      setState(() {
        StaticData.data.clear();
        allProviders =
            ProvidersResponse.fromJson(json.decode(response.toString()));
        StaticData.data.addAll(allProviders.beauticians);
        StaticData.providers_list = StaticData.data;
        isLoading = false;
      });
    } else {}
  }

  void getAllCities() async {
    Response response = await _util.get(
      "cities/get-all-cities?lang=${translator.currentLanguage}",
    );

    if (response.data["status"] == true) {
      setState(() {
        allCities = CitiesResponse.fromJson(json.decode(response.toString()));
      });
    } else {}
  }

  void searchByCategoryId(int id, String name) async {
    showLoadingDialog(context);
    Response response = await _util.get(
      "users/search/key-search?value_name=$id&key=category_id",
    );
    if (response.data["status"] == true) {
      setState(() {
        StaticData.data.clear();
        resultRess =
            SearchResultResponse.fromJson(json.decode(response.toString()));
        category_name = name;
        countBeautician = resultRess.data.countBeautician;
        StaticData.data.addAll(resultRess.data.beauticianServices);
        Navigator.pop(context);

        category_status = true; // use in search inside categories data

      });
    } else {
      Navigator.pop(context);
      errorDialog(context: context, text: response.data["msg"]);
    }
  }

  void searchByCities(int id) {

    if(frist_time_search){

    }else{
      StaticData.data.clear();
      StaticData.data = StaticData.providers_list;
    }
    StaticData.providers_list.forEach((element) {
      if (StaticData.data.contains(element)) {
      } else {
        StaticData.data.add(element);
      }
    });
    for (int i = 0; i < allProviders.beauticians.length; i++) {

        if (allProviders.beauticians[i].cityId == id) {
          setState(() {
            searshResult.add(StaticData.data[i]);
          });

      }

    }

    setState(() {
      StaticData.data = searshResult;
      frist_time_search = false;
    });
    Navigator.pop(context);
  }

  void chosse_when() async {
    when_value = await sharedPreferenceManager.readString(CachingKey.WHEN_DATE);
  }

  void getFromCash() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var logged =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
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
      onUnavailableDaySelected: () {},
      calendarStyle: CalendarStyle(
          highlightToday: false,
          selectedColor: Color(0xFFDBB2D2),
          highlightSelected: true,
          selectedStyle: TextStyle(color: Color(0xFFDBB2D2)),
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
              TextStyle(color: Color(0xFFDBB2D2)).copyWith(fontSize: 16.0),
            ),
          ),
        ),
      );
           },

      ),
    );
  }

  List<String> timeList = [
    "10:00 AM", "10:30 AM", "11:00 AM", "11:30 AM", "12:00 PM", "12:30 PM", "01:00 PM", "01:30 PM", "02:00 PM", "02:30 PM",
    "03:00 PM", "03:30 PM", "04:00 PM", "04:30 PM", "05:00 PM", "05:30 PM", "06:00 PM", "06:30 PM", "07:00 PM", "07:30 PM",
    "08:00 PM", "08:30 PM", "09:00 PM","09:30 PM", "10:00 PM", "10:30 PM", "11:00 PM", "11:30 PM"
  ];
  void searchByTime(String time, String date) async {
    StaticData.data.forEach((element) {
      StaticData.providers_searh_when.add(element);
    });
    showLoadingDialog(context);
    Response response = await _util
        .get("users/search/search-beautician-time?time=$time&date=${date}");
    if (response.data["status"] == true) {
      StaticData.providers_list = StaticData.data;
      setState(() {
        StaticData.data.clear();
        resultRess =
            SearchResultResponse.fromJson(json.decode(response.toString()));
        StaticData.data.addAll(resultRess.data.beauticianServices);
        Navigator.pop(context);
      });
    } else {
      Navigator.pop(context);
      errorDialog(context: context, text: response.data["msg"]);
    }
  }
}
