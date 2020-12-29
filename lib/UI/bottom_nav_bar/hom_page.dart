import 'package:buty/Bolcs/get_all_beutions.dart';
import 'package:buty/Bolcs/get_category_bloc.dart';
import 'package:buty/Bolcs/search_by_name_bloc.dart';
import 'package:buty/Bolcs/search_by_time_bloc.dart';
import 'package:buty/UI/CustomWidgets/AppLoader.dart';
import 'package:buty/UI/CustomWidgets/CustomBottomSheet.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:buty/UI/CustomWidgets/ErrorDialog.dart';
import 'package:buty/UI/CustomWidgets/LoadingDialog.dart';
import 'package:buty/UI/component/single_provider_item_row.dart';
import 'package:buty/UI/pic_location.dart';
import 'package:buty/UI/SearchResult.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/helpers/shared_preference_manger.dart';
import 'package:buty/models/all_providers_response.dart';
import 'package:buty/models/categories_response.dart';
import 'package:buty/models/search_by_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
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
    allProvicersBloc.add(Hydrate());
    super.initState();
  }

  void getFromCash() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var logged =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print("USER STATUS${logged != " " ? false : true}");
  }

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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchResult(
                                    beauticianServices:
                                        data.data.beauticianServices,
                                  )));
                    }
                  },
                  child: CustomTextField(
                    onSubmitted: (String val) {
                      searchByNameBloc.updateName(val);
                      print("Submittteed  Val===> ${val}");
                      searchByNameBloc.add(Click());
                    },
                    value: (String val) {
                      searchByNameBloc.updateName(val);
                    },
                    hint: translator.translate("search"),
                    icon: InkWell(
                        onTap: () {
                          searchByNameBloc.add(Click());
                        },
                        child: Icon(Icons.search)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChooseLocation()));
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.add_location,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    Text(translator.translate("where"), style: TextStyle(fontWeight: FontWeight.bold),),
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
                                padding: const EdgeInsets.symmetric(horizontal: 40),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.timer,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    Text(translator.translate("when") , style: TextStyle(fontWeight: FontWeight.bold),),
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
        hight: MediaQuery.of(context).size.height / 3,
        widget: Column(
          children: [
            Text(
              translator.translate("enter_time"),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            TimePicker(),
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
                child: CustomButton(
                  onBtnPress: () {
                    Navigator.pop(context);
                    searchByTimeBloc.add(Click());
                  },
                  text: "${translator.translate("done")}",
                ))
          ],
        ));
  }

  Widget TimePicker() {
    return new TimePickerSpinner(
      is24HourMode: false,
      normalTextStyle: TextStyle(fontSize: 18, color: Colors.black),
      highlightedTextStyle:
          TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
      spacing: 30,
      itemHeight: 50,
      isForce2Digits: true,
      onTimeChange: (time) {
        searchByTimeBloc.updateId(time.toString().substring(10, 16));
      },
    );
  }
}
