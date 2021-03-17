import 'dart:convert';

import 'package:buty/Base/old_netWork.dart';
import 'package:buty/Bolcs/get_category_bloc.dart';
import 'package:buty/UI/CustomWidgets/AppLoader.dart';
import 'package:buty/UI/CustomWidgets/CustomBottomSheet.dart';
import 'package:buty/UI/CustomWidgets/ErrorDialog.dart';
import 'package:buty/UI/CustomWidgets/LoadingDialog.dart';
import 'package:buty/UI/SearchResult.dart';
import 'package:buty/UI/component/single_provider_item_row.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/helpers/shared_preference_manger.dart';
import 'package:buty/models/categories_response.dart';
import 'package:buty/models/cites_response.dart';
import 'package:buty/models/providers_response.dart';
import 'package:buty/models/search_by_category.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getFromCash();
    getCategoriesBloc.add(Hydrate());
    getHomeData();
    getAllCities();
    super.initState();
  }

  void getFromCash() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var logged =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print("USER STATUS${logged != " " ? false : true}");
  }

  ProvidersResponse allProviders = ProvidersResponse();
  CitiesResponse allCities = CitiesResponse();
  List<AllButicans> data = [];
  List<AllButicans> searshResult = [];
  OldNetworkUtil _util = OldNetworkUtil();
  bool isLoading = true;
  String time = null;

  SearchResultResponse resultRess = SearchResultResponse();

  void getHomeData() async {
    Response response = await _util.get(
      "user/provider/get-all-provider?lang=${translator.currentLanguage}",
    );
    print(response.statusCode);
    if (response.data["status"] == true) {
      print("Donee ");
      setState(() {
        data.clear();
        allProviders =
            ProvidersResponse.fromJson(json.decode(response.toString()));
        data.addAll(allProviders.beauticians);
        isLoading = false;
      });
    } else {
      print("Error");
    }
  }

  void getAllCities() async {
    print("In CITIES Service");
    Response response = await _util.get(
      "cities/get-all-cities?lang=ar",
    );
    print("STATUS CODE =========> ${response.statusCode}");
    print("RESPONSE =========> ${response}");

    if (response.data["status"] == true) {
      print("Donee");
      setState(() {
        allCities = CitiesResponse.fromJson(json.decode(response.toString()));
      });
    } else {
      print("Error");
    }
  }

  void searchByCategoryId(int id, String name) async {
    showLoadingDialog(context);
    print("In Categoreis Service");
    Response response = await _util.get(
      "users/search/key-search?value_name=$id&key=category_id ",
    );
    print("STATUS CODE =========> ${response.statusCode}");
    print("RESPONSE =========> ${response}");
    if (response.data["status"] == true) {
      print("Donee");
      setState(() {
        data.clear();
        resultRess =
            SearchResultResponse.fromJson(json.decode(response.toString()));
        // data.addAll(resultRess.data.beauticianServices);
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchResult(
                      name: name,
                      beauticianServices: resultRess.data.beauticianServices,
                    )));
      });
    } else {
      Navigator.pop(context);
      errorDialog(context: context, text: response.data["msg"]);
      print("Error");
    }
  }

  void searchByTime(String id) async {
    showLoadingDialog(context);
    print("In Time Service");
    Response response = await _util.get(
      "users/search/key-search?value_name=$id&key=time",
    );
    print("STATUS CODE =========> ${response.statusCode}");
    print("RESPONSE =========> ${response}");
    if (response.data["status"] == true) {
      print("Donee");
      setState(() {
        data.clear();
        resultRess =
            SearchResultResponse.fromJson(json.decode(response.toString()));
        data.addAll(resultRess.data.beauticianServices);
        Navigator.pop(context);
      });
    } else {
      Navigator.pop(context);
      errorDialog(context: context, text: response.data["msg"]);
      print("Error");
    }
  }

  void search(String keyWord) {
    for (int i = 0; i < allProviders.beauticians.length; i++) {
      if (allProviders.beauticians[i].beautName.contains(keyWord)) {
        setState(() {
          searshResult.add(data[i]);
        });
      }
    }
    print(json.encode(searshResult));
    setState(() {
      data = searshResult;
    });
  }

  void searchByCities(int id) {
    print("IDD =======>  ${id}");
    for (int i = 0; i < allProviders.beauticians.length; i++) {
      print("IDD =======>  ${allProviders.beauticians[i].cityId}");
      if (allProviders.beauticians[i].cityId == id) {
        setState(() {
          searshResult.add(data[i]);
        });
      }
    }
    print(json.encode(searshResult));
    setState(() {
      data = searshResult;
    });
    Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    child: TextField(
                      onSubmitted: (v) {
                        print(v);
                        search(v);
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "${translator.translate("search")}",
                        border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10 ?? 10.0),
                          borderSide: new BorderSide(
                              color: Theme.of(context).primaryColor, width: 1),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            hight: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
                                            widget: ListView.builder(
                                                itemCount:
                                                    allCities.cities.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      searchByCities(allCities
                                                          .cities[index].id);
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "${allCities.cities[index].nameEn}",
                                                          style: TextStyle(
                                                              fontSize: 18),
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                            child: Image.asset(
                                                "assets/images/car.png"),
                                          ),
                                          Text(translator.translate("at_buty")),
                                        ],
                                      )),
                                  InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        CustomSheet(
                                            context: context,
                                            hight: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
                                            widget: ListView.builder(
                                                itemCount:
                                                    allCities.cities.length,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      searchByCities(allCities
                                                          .cities[index].id);
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "${allCities.cities[index].nameEn}",
                                                          style: TextStyle(
                                                              fontSize: 18),
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.2,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  3,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                              child: Icon(
                                                Icons.home,
                                                size :80 ,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              )),
                                          Text(translator.translate("at_buty")),
                                        ],
                                      )),
                                ],
                              ));
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.add_location,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    Text(
                                      translator.translate("where"),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          timeDialog();
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.timer,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    Text(
                                      time ?? translator.translate("when"),
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    data.msg == "الرمز المميز غير موجود"
                                        ? "عفواً يرجي تسجيل الدخول اولاًً "
                                        : data.msg == "الرمز المميز غير موجود"
                                            ? "Authorization Token Not Found"
                                            : "Sorry You Must Log In First",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))
                              : AnimationLimiter(
                                  child: Container(
                                    height: 120,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: data.categories.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return AnimationConfiguration
                                            .staggeredList(
                                          position: index,
                                          duration:
                                              const Duration(milliseconds: 375),
                                          child: SlideAnimation(
                                            verticalOffset: 50.0,
                                            child: FadeInAnimation(
                                                child: cat_item(
                                                    data.categories[index].icon,
                                                    translator.currentLanguage ==
                                                            "ar"
                                                        ? data.categories[index]
                                                            .nameAr
                                                        : data.categories[index]
                                                            .nameEn,
                                                    data.categories[index].id)),
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
          isLoading == true
              ? AppLoader()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return SingleProviderItemRow(
                          beautic: data[index],
                        );
                      }),
                ),
        ],
      ),
    );
  }

  Widget cat_item(String image, String name, int id) {
    return InkWell(
      onTap: () {
        searchByCategoryId(id, name);
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        child: Column(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.cover)),
            ),
            Text(
              name,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  void timeDialog() {
    CustomSheet(
        context: context,
        hight: MediaQuery.of(context).size.height / 2.3,
        widget: ListView.builder(
          itemCount: timeList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  time = timeList[index];
                  searchByTime(time);
                });
              },
              child: Column(
                children: [
                  Text(
                    timeList[index],
                    textDirection: TextDirection.ltr,
                  ),
                  Divider()
                ],
              ),
            );
          },
        ));
  }
}
