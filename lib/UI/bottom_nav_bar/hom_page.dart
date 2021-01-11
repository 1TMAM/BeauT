import 'package:buty/Bolcs/get_all_beutions.dart';
import 'package:buty/Bolcs/get_category_bloc.dart';
import 'package:buty/Bolcs/search_by_name_bloc.dart';
import 'package:buty/Bolcs/search_by_time_bloc.dart';
import 'package:buty/UI/CustomWidgets/AppLoader.dart';
import 'package:buty/UI/CustomWidgets/CustomBottomSheet.dart';
import 'package:buty/UI/CustomWidgets/ErrorDialog.dart';
import 'package:buty/UI/CustomWidgets/LoadingDialog.dart';
import 'package:buty/UI/SearchResult.dart';
import 'package:buty/UI/bottom_nav_bar/searchBytime.dart';
import 'package:buty/UI/component/single_provider_item_row.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/helpers/shared_preference_manger.dart';
import 'package:buty/models/all_providers_response.dart';
import 'package:buty/models/categories_response.dart';
import 'package:buty/models/search_by_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../pic_location.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getFromCash();
    getCategoriesBloc.add(Hydrate());
    allProvicersBloc.add(Hydrate());
    super.initState();
  }

  void getFromCash() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var logged =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print("USER STATUS${logged != " " ? false : true}");
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
            height: MediaQuery.of(context).size.height / 2.8,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocListener(
                  bloc: searchByNameBloc,
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
                                        data.data.beauticianServices,
                                  )));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      child: TextField(
                        onChanged: (String val) {
                          print(val);
                          searchByNameBloc.updateName(val);
                        },
                        onSubmitted: (v) {
                          searchByNameBloc.add(Click());
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "${translator.translate("search")}",
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10 ?? 10.0),
                            borderSide: new BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 1),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        ),
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
                              hight: MediaQuery.of(context).size.height / 3,
                              widget: Column(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChooseLocation()));
                                      },
                                      child: Text(
                                        "${translator.translate("at_home")}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Divider(),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChooseLocation()));
                                      },
                                      child: Text(
                                        "${translator.translate("at_buty")}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchByTime()));
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
                                      translator.translate("when"),
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
          BlocListener<AllProvicersBloc, AppState>(
            bloc: allProvicersBloc,
            listener: (context, state) {},
            child: BlocBuilder(
              bloc: allProvicersBloc,
              builder: (context, state) {
                var data = state.model as AllProvidersResponse;
                return data == null
                    ? AppLoader()
                    : AnimationLimiter(
                        child: ListView.builder(
                          padding: EdgeInsets.all(8),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: data.beauticians.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: SingleProviderItemRow(
                                    beautic: data.beauticians[index],
                                  ),
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
      ),
    );
  }

  Widget cat_item(String image, String name, int id) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchResult(
                      name: name,
                      cat_id: id,
                    )));
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
        widget: BlocListener(
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
          child: ListView.builder(
              itemCount: timeList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    print(timeList[index]);
                    searchByTimeBloc.updateId(timeList[index]);
                    searchByTimeBloc.add(Click());
                  },
                  child: Column(
                    children: [
                      Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            "${timeList[index]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )),
                      Divider(),
                    ],
                  ),
                );
              }),
        ));
  }
}
