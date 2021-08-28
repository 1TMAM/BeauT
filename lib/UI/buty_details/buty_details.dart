import 'dart:convert';

import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/Base/shared_preference_manger.dart';
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
import 'package:buty/models/BeauticianDetails.dart';
import 'package:buty/models/providers_response.dart' as providers_response;

import 'package:buty/models/my_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:url_launcher/url_launcher.dart';

class ButyDetails extends StatefulWidget {
  final int id;
  final String name;
  final int reviews;
  final String beautician_name;
  final String insta_link;
  final double rate;
  final List<providers_response.Gallery> gallery;
  const ButyDetails({Key key, this.id, this.name,this.reviews,this.rate,this.beautician_name,this.insta_link,this.gallery}) : super(key: key);

  @override
  _ButyDetailsState createState() => _ButyDetailsState();
}

class _ButyDetailsState extends State<ButyDetails> {
  int _current = 0;

  bool isLogged = false;

  List<int> allPrices = [];
  List<MyList> servicesList =[];
  int total = 0;

  void getFromCash() async {
    var logged =
        await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);

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
        "Valuee ===>  ${sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}");

    print("USER STATUS    ======> ${isLogged == true ? "User" : "Geust"}");
  }

  @override
  void initState() {
    getFromCash();
    getBeauticianDetailsBloc.updateId(widget.id);
    getBeauticianDetailsBloc.add(Hydrate());
    createOrderBloc.updateBeauticianId(widget.id);
    print("BeauticianId :  ${widget.id}");
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
           // leading:  ,
            centerTitle: true,
            title: Text(
              widget.name ?? "Buty Name",
              textDirection: TextDirection.ltr,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
        actions: [
            Padding(padding: EdgeInsets.only(right: 10,left: 10),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainPage(
                                index: 0,
                              )));
                    },
                    child:  Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    )),)
      ],
        ),
        body: BlocListener<GetBeauticianDetailsBloc, AppState>(
          bloc: getBeauticianDetailsBloc,
          listener: (context, state) {
            SharedPreferenceManager pref = SharedPreferenceManager();
          },
          child: BlocBuilder(
            bloc: getBeauticianDetailsBloc,
            builder: (context, state) {
              var data = state.model as BeauticianDetailsResponse;
              if(state is Loading){
                return AppLoader();
              }else if(state is Done){
                return data.beautician == null
                    ? Container(
                  child: Center(
                    child: Text(data.msg),
                  ),
                )
                    : ListView(
                  children: [
                    Stack(
                      children: [

                        widget.gallery.length==1?  Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.width * 0.6,
                          child: Image.network(widget.gallery[0].photo, fit: BoxFit.fitWidth,)

                        ):   CustomCarousel(
                          img:  widget.gallery,
                        ),
                        Positioned(
                            top: 0,
                            left: 20,
                            child: Container(
                              color: Colors.grey.shade700,
                              width: MediaQuery.of(context).size.width/4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${widget.rate.toInt()}",
                                        style: TextStyle(color: Colors.white),),
                                      SizedBox(width: 5,),
                                      Icon(Icons.star,color: Theme.of(context).primaryColor,size: 15,),
                                    ],
                                  ),
                                  Text("${widget.reviews}   ${translator.translate('reviews')}" , style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            ))

                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: Text(
                        "${widget.beautician_name}",
                        //   textDirection: TextDirection.ltr,

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
                                itemCount: data.beautician[0].categories.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child:  Padding(
                                          padding: EdgeInsets.only(left: 10,right: 10),
                                          child: Image.network(data.beautician[0].categories[index].icon)
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                          onTap: (){
                            _launchURL(widget.insta_link);
                          },
                          child: Row(
                            /*  crossAxisAlignment: translator.currentLanguage =='ar' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              mainAxisAlignment:translator.currentLanguage =='ar' ? MainAxisAlignment.end :  MainAxisAlignment.start,*/
                            children: [
                              Expanded(
                                  flex:1,
                                  child:   Text(
                                    "${translator.translate("Instagram : ")} ",)),
                              Expanded(
                                flex:3,
                                child: Text(
                                  widget.insta_link ==null ? '' :" ${ widget.insta_link} ",style: TextStyle(color: Colors.blueAccent),),)
                            ],
                          )
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                          "${translator.translate( "city")}  : ${translator.currentLanguage =='ar' ?
                          data.beautician[0].city.nameAr : data.beautician[0].city.nameEn}  "),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "${translator.translate("services")}  ",
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: data.beautician[0].services.length,
                            itemBuilder: (context, index) {
                              return serviceRow(
                                  data.beautician[0].services, index);
                            })),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.05,
                    ),
                    InkWell(
                        onTap: () {
                          if (isLogged == true) {
                            if (servicesList.isEmpty) {
                              errorDialog(
                                  context: context,
                                  text:
                                  translator.translate("enter_items"));
                            } else {
                              print("servicesList : ${servicesList}");
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
                          "${translator.translate( "payment")}  ${total}  ${translator.translate("sar")}",
                        ))
                  ],
                );
              }else{
                return AppLoader();
              }

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
                              print("------- frist -------");
                              servicesList.add(new MyList(
                                  id: list[index].id,
                                  price: list[index].price,
                                  nameAr: list[index].nameAr,
                                  nameEn: list[index].nameEn,
                                  estimatedTime: list[index].estimatedTime,
                                  count: list[index].count));
                              print(json.encode(servicesList));
                              print("------- frist 1 -------");
                            }
                            else {
                              print("servicesList.length : ${servicesList.length}");
                              for (int i = 0; i < servicesList.length; i++) {
                                print("servicesList[i].id  : ${servicesList[i].id }");
                                print("list[i].id  : ${list[i].id }");

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
                                      count: list[index].count)
                                  );
                                  print(json.encode(servicesList));
                                } else {
                                  print("New");

                                servicesList.add(new MyList(
                                        id: list[index].id,
                                        price: list[index].price,
                                        nameAr: list[index].nameAr,
                                        nameEn: list[index].nameEn,
                                        estimatedTime: list[index].estimatedTime,
                                        count: list[index].count)
                                );

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
                                servicesList.remove(list[index]);
                                print("remove serviceList : ${servicesList}");
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

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
