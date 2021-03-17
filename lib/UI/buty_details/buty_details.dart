import 'dart:convert';

import 'package:buty/Bolcs/creat_order_bloc.dart';
import 'package:buty/Bolcs/getBeauticianDetailsBloc.dart';
import 'package:buty/UI/Auth/login.dart';
import 'package:buty/UI/CustomWidgets/AppLoader.dart';
import 'package:buty/UI/CustomWidgets/Carousel.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/ErrorDialog.dart';
import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'package:buty/UI/buty_details/choose_date.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/helpers/shared_preference_manger.dart';
import 'package:buty/models/BeauticianDetails.dart';
import 'package:buty/models/my_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ButyDetails extends StatefulWidget {
  final int id;
  final String name;

  const ButyDetails({Key key, this.id, this.name}) : super(key: key);

  @override
  _ButyDetailsState createState() => _ButyDetailsState();
}

class _ButyDetailsState extends State<ButyDetails> {
  int _current = 0;

  bool isLogged = false;

  List<int> allPrices = List();
  List<MyList> servicesList = List();
  int total = 0;

  void getFromCash() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var logged =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);

    if (logged == "") {
      setState(() {
        isLogged = false;
      });
    } else {
      setState(() {
        isLogged = true;
      });
    }
    print(
        "Valuee ===>  ${mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}");

    print("USER STATUS    ======> ${isLogged == true ? "User" : "Geust"}");
  }

  @override
  void initState() {
    getFromCash();
    getBeauticianDetailsBloc.updateId(widget.id);
    getBeauticianDetailsBloc.add(Hydrate());
    createOrderBloc.updateBeauticianId(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translator.currentLanguage == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
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
              widget.name ?? "Buty Name",
              textDirection: TextDirection.ltr,
              style: TextStyle(color: Colors.white, fontSize: 17),
            )),
        body: BlocListener<GetBeauticianDetailsBloc, AppState>(
          bloc: getBeauticianDetailsBloc,
          listener: (context, state) {
            SharedPreferenceManager pref = SharedPreferenceManager();
          },
          child: BlocBuilder(
            bloc: getBeauticianDetailsBloc,
            builder: (context, state) {
              var data = state.model as BeauticianDetailsResponse;
              return data == null
                  ? AppLoader()
                  : ListView(
                      children: [
                        CustomCarousel(
                          img: data.beautician[0].gallery,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "${widget.name}",
                            textDirection: TextDirection.ltr,

                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Text(
                                "${translator.translate("services")} : ",
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 100,
                                height: 50,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        data.beautician[0].services.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(data
                                                      .beautician[0]
                                                      .services[index]
                                                      .icon),
                                                  fit: BoxFit.cover),
                                              color: Colors.grey[200],
                                              shape: BoxShape.circle),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                              "${translator.translate("location")}  : ${data.beautician[0].address}  "),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "${translator.translate("services")}  ",
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: data.beautician[0].services.length,
                            itemBuilder: (context, index) {
                              return serviceRow(
                                  data.beautician[0].services, index);
                            }),
                        InkWell(
                            onTap: () {
                              if (isLogged == true) {
                                if (servicesList.isEmpty) {
                                  errorDialog(
                                      context: context,
                                      text:
                                          translator.translate("enter_items"));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChooseDate(
                                                total: total,
                                                servicseList: servicesList,
                                              )));
                                }
                              } else {
                                errorDialog(
                                    text: translator.currentLanguage == "ar"
                                        ? "يرجي تسجيل الدخول اولاًً "
                                        : " You Must Login Frist",
                                    context: context,
                                    function: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login())));
                              }
                            },
                            child: CustomButton(
                              text:
                                  "${translator.translate("choose_time")} ${total} ${translator.translate("sar")}",
                            ))
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget serviceRow(List<Services> list, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 4,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/4,
                      child: Text(
                        "${translator.currentLanguage == "ar" ? list[index].nameAr : list[index].nameEn}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translator.translate("persons"),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              list[index].count++;
                              total = total + (int.parse(list[index].price));
                            });

                            if (servicesList.isEmpty) {
                              servicesList.add(new MyList(
                                  id: list[index].id,
                                  price: list[index].price,
                                  nameAr: list[index].nameAr,
                                  nameEn: list[index].nameEn,
                                  estimatedTime: list[index].estimatedTime,
                                  count: list[index].count));
                              print(json.encode(servicesList));
                            }
                            else {
                              for (int i = 0; i < servicesList.length; i++) {
                                if (servicesList[i].id == list[index].id) {
                                  print("Edited");
                                  print("SERVICE ID ==> ${servicesList[i].id}");
                                  print("LIST ID ===> ${list[index].id}");
                                  print(list[index].count);
                                  servicesList.removeAt(i);
                                  servicesList.add(new MyList(
                                      id: list[index].id,
                                      price: list[index].price,
                                      nameAr: list[index].nameAr,
                                      nameEn: list[index].nameEn,
                                      estimatedTime: list[index].estimatedTime,
                                      count: list[index].count));
                                  print(json.encode(servicesList));
                                } else {
                                  print("New");
                                  servicesList.add(new MyList(
                                      id: list[index].id,
                                      price: list[index].price,
                                      nameAr: list[index].nameAr,
                                      nameEn: list[index].nameEn,
                                      estimatedTime: list[index].estimatedTime,
                                      count: list[index].count));

                                  print(json.encode(servicesList));
                                  break;
                                }
                              }
                            }
                          },
                          child: Icon(
                            Icons.add,
                            size: 25,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "${list[index].count}",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (list[index].count == 0) {
                              print("LLLLL");
                            } else {
                              setState(() {
                                list[index].count--;
                                total = total - (int.parse(list[index].price));
                              });
                            }
                          },
                          child: Icon(
                            Icons.remove,
                            size: 25,
                          ),
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
                width: MediaQuery.of(context).size.width / 3.5,
                child: Text(
                  "${translator.currentLanguage == "ar" ? list[index].detailsAr : list[index].detailsEn}  ",
                  style: TextStyle(fontSize: 10),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Text(
                            "${list[index].price} ${translator.translate("sar")}",
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            "${list[index].estimatedTime} ${translator.translate("min")}",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 5),
                    //   child: InkWell(
                    //     onTap: () {
                    //       if (list[index].count == 0) {
                    //         errorDialog(
                    //             context: context,
                    //             text: "${translator.translate("enter_items")}");
                    //       } else {
                    //       }
                    //     },
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //           color: Theme.of(context).primaryColor,
                    //           borderRadius: BorderRadius.circular(5)),
                    //       child: Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 20, vertical: 1),
                    //         child: Text(
                    //           translator.translate("reserve"),
                    //           style: TextStyle(color: Colors.white),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
