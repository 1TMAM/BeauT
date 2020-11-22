import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/Bolcs/get_all_beutions.dart';
import 'package:buty/Bolcs/get_category_bloc.dart';
import 'package:buty/Bolcs/search_by_address_bloc.dart';
import 'package:buty/Bolcs/search_by_name_bloc.dart';
import 'package:buty/Bolcs/search_by_time_bloc.dart';
import 'package:buty/UI/CustomWidgets/AppLoader.dart';
import 'package:buty/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:buty/UI/CustomWidgets/ErrorDialog.dart';
import 'package:buty/UI/CustomWidgets/LoadingDialog.dart';
import 'package:buty/UI/component/single_provider_item_row.dart';
import 'package:buty/UI/searchBy_cat_id.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/helpers/shared_preference_manger.dart';
import 'package:buty/models/all_providers_response.dart';
import 'package:buty/models/categories_response.dart';
import 'package:buty/models/search_by_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

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
    print( "USER STATUS${logged  !=" "? false : true}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height:  MediaQuery.of(context).size.width / 1.4,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: CustomTextField(
                          value: (String val) {
                            searchByNameBloc.updateName(val);
                          },
                          hint: allTranslations.text("search"),
                          icon: InkWell(
                              onTap: () {
                                searchByNameBloc.add(Click());
                              },
                              child: Icon(Icons.search)),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocListener(
                        bloc: searchByAddressBloc,
                        listener: (context, state) {
                          var data = state.model as SearchByCategoryResponse;
                          if (state is Loading) showLoadingDialog(context);
                          else if (state is ErrorLoading) {
                            Navigator.of(context).pop();
                            errorDialog(
                              context: context,
                              text: data.msg,
                            );
                          }
                         else if (state is Done) {
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchResult(
                                          beauticianServices: data.data
                                                      .beauticianServices ==
                                                  null
                                              ? null
                                              : data.data.beauticianServices,
                                        )));
                          }
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2.4,
                            child: CustomTextField(
                              hint: allTranslations.text("where"),
                              icon: Icon(Icons.location_on),
                              onSubmitted: (String val) {
                                searchByAddressBloc.updateAddress(val);

                                print(val);
                                searchByAddressBloc.add(Click());
                              },
                              inputType: TextInputType.text,
                              value: (String val) {
                                print("=====" + val);
                                searchByAddressBloc.updateAddress(val);
                              },
                            )),
                      ),
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
                                          beauticianServices: data.data
                                                      .beauticianServices ==
                                                  null
                                              ? null
                                              : data.data.beauticianServices,
                                        )));
                          }
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2.4,
                            child: CustomTextField(
                              hint: allTranslations.text("when"),
                              onSubmitted: (String val) {
                                searchByTimeBloc.updateId(val);
                                print(val);
                                searchByTimeBloc.add(Click());
                              },
                              icon: Icon(Icons.lock_clock),
                              inputType: TextInputType.number,
                              value: (String val) {
                                print("=====" + val);
                                searchByTimeBloc.updateId(val);
                              },
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
                              ? Center(child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 30),
                                child: Text( data.msg == "الرمز المميز غير موجود"
                                    ? "عفواً يرجي تسجيل الدخول اولاًً "
                                    : data.msg == "الرمز المميز غير موجود"
                                    ? "Authorization Token Not Found"
                                    : "Sorry You Must Log In First" ,style: TextStyle(color: Colors.white),),
                              ))
                              : AnimationLimiter(
                                  child: Container(
                                    height: 110,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
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
                                                   allTranslations.currentLanguage =="ar"? data.categories[index]
                                                        .nameAr:data.categories[index]
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
                    : data.beauticians == null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 100),
                            child: Center(child: Text(data.msg)),
                          )
                        : AnimationLimiter(
                            child: ListView.builder(
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
        width: MediaQuery.of(context).size.width / 3.3,
        child: Column(
          children: [
            Container(
              height: 80,
              // child: Center(
              //   child: Image.network(
              //     image,
              //     fit: BoxFit.cover,
              //     width: 50,
              //     height: 50,
              //   ),
              // ),
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
}
