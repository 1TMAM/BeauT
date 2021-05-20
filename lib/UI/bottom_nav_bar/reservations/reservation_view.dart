import 'package:buty/Bolcs/canselOrderBloc.dart';
import 'package:buty/Bolcs/get_current_orders_bloc.dart';
import 'package:buty/UI/CustomWidgets/AppLoader.dart';
import 'package:buty/UI/CustomWidgets/CustomBottomSheet.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/EmptyItem.dart';
import 'package:buty/UI/CustomWidgets/ErrorDialog.dart';
import 'package:buty/UI/CustomWidgets/LoadingDialog.dart';
import 'package:buty/UI/CustomWidgets/on_done_dialog.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/current_ordera_model.dart';
import 'package:buty/models/general_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CurrentReservationView extends StatefulWidget {
  @override
  _CurrentReservationViewState createState() => _CurrentReservationViewState();
}

class _CurrentReservationViewState extends State<CurrentReservationView> {
  @override
  void initState() {
    currentOrdersBloc.add(Hydrate());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrentOrdersBloc, AppState>(
      bloc: currentOrdersBloc,
      listener: (context, state) {},
      child: BlocBuilder(
        bloc: currentOrdersBloc,
        builder: (context, state) {
          var data = state.model as CurrentOrdersResponse;

          return data == null
              ? AppLoader()
              : data.orders == null
                  ? Center(
                      child: EmptyItem(
                      text: data.msg == "الرمز المميز غير موجود"
                          ? translator.currentLanguage=='ar' ? "عفواً يرجي تسجيل الدخول اولاًً " :  "Sorry You Must Log In First"
                          :translator.currentLanguage=='ar' ? 'عفوا لا يوجد طلبات حتى الان' : "Sorry There Is No Orders Added Yet ",
                    ))
                  : AnimationLimiter(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: data.orders.length,
                        itemBuilder: (BuildContext context, int index) {
                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  // height:
                                  //     MediaQuery.of(context).size.height / 2.6,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                                "${translator.translate("section")} "),
                                            Text(
                                              "${translator.currentLanguage == "ar" ? data.orders[index].services[0].nameAr : data.orders[index].services[0].nameEn}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                                "${translator.translate("buty_name")}"),
                                            Text(
                                              "${data.orders[index].beautician==null?'' :data.orders[index].beautician.beautName}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                                "${translator.translate("time")} "),
                                            Text(
                                              " ${data.orders[index].time} ",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                                "${translator.translate("date")}"),
                                            Text(
                                              "${data.orders[index].date}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Wrap(
                                          children: [
                                            Text(
                                                "${translator.translate("details")}  "),
                                            Text(
                                              "${translator == "ar" ? data.orders[index].services[0].detailsAr : data.orders[index].services[0].detailsEn}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                                "${translator.translate("cost")} "),
                                            Text(
                                              "  ${data.orders[index].cost}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            CustomSheet(
                                                context: context,
                                                widget: cansel(
                                                    data.orders[index].id),
                                                hight: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    3.5);
                                          },
                                          child: CustomButton(
                                            text:
                                                "${translator.translate("cansel")}",
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.grey[500]),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              )),
                            ),
                          );
                        },
                      ),
                    );
        },
      ),
    );
  }

  Widget cansel(int id) {
    print(id);
    return BlocListener(
      bloc: canselOrderbloc,
      listener: (context, state) {
        var data = state.model as GeneralResponse;
        if (state is Loading) {
          showLoadingDialog(context);
        } else if (state is ErrorLoading) {
          errorDialog(context: context, text: data.msg);
        } else if (state is Done) {
          Navigator.pop(context);

          onDoneDialog(
              context: context,
              text: data.msg,
              function: () {
                Navigator.pop(context);
                Navigator.pop(context);
                currentOrdersBloc.add(Hydrate());
              });
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              translator.translate("validate_cansel"),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              CustomButton(
                onBtnPress: () {
                  canselOrderbloc.updateId(id);
                  canselOrderbloc.updateStatus(4);
                  canselOrderbloc.add(Click());
                },
                width: MediaQuery.of(context).size.width / 2.8,
                text: translator.translate("yes"),
              ),
              CustomButton(
                onBtnPress: () {
                  Navigator.pop(context);
                },
                width: MediaQuery.of(context).size.width / 2.8,
                text: translator.translate("no"),
                textColor: Colors.black,
                color: Colors.white,
                raduis: 1,
              ),
            ],
          )
        ],
      ),
    );
  }
}
