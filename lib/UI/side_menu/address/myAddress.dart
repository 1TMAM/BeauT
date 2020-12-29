import 'package:buty/Bolcs/my_address_bloc.dart';
import 'package:buty/UI/CustomWidgets/AppLoader.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/EmptyItem.dart';
import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'package:buty/UI/component/address_row.dart';
import 'package:buty/UI/side_menu/address/add_new_location.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/my_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class MyAddresses extends StatefulWidget {
  @override
  _MyAddressesState createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {
  @override
  void initState() {
    myAdressBloc.add(Hydrate());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translator.currentLanguage == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: WillPopScope(
        onWillPop: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              ),
              (Route<dynamic> route) => false);
        },
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
                translator.translate("my_adresses"),
                style: TextStyle(color: Colors.white, fontSize: 14),
              )),
          body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              children: [
                BlocListener<MyAdressBloc, AppState>(
                  bloc: myAdressBloc,
                  listener: (context, state) {},
                  child: BlocBuilder(
                    bloc: myAdressBloc,
                    builder: (context, state) {
                      var data = state.model as MyAddressResponse;
                      return data == null
                          ? AppLoader()
                          : data.locations == null
                              ? Center(
                                  child: EmptyItem(
                                  text: data.msg == "الرمز المميز غير موجود"
                                      ? "عفواً يرجي تسجيل الدخول اولاًً "
                                      : data.msg == "الرمز المميز غير موجود"
                                          ? "Authorization Token Not Found"
                                          : "Sorry You Must Log In First",
                                ))
                              : AnimationLimiter(
                                  child: Column(
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: data.locations.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return AnimationConfiguration
                                              .staggeredList(
                                            position: index,
                                            duration: const Duration(
                                                milliseconds: 375),
                                            child: SlideAnimation(
                                              verticalOffset: 50.0,
                                              child: FadeInAnimation(
                                                  child: AddressRow(
                                                address: data.locations[index],
                                              )),
                                            ),
                                          );
                                        },
                                      ),
                                      CustomButton(
                                        onBtnPress: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddNewLocation()));
                                        },
                                        text: translator
                                            .translate("add_new_location"),
                                      )
                                    ],
                                  ),
                                );
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
