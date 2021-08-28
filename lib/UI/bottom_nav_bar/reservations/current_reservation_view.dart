import 'package:buty/Bolcs/canselOrderBloc.dart';
import 'package:buty/Bolcs/get_current_orders_bloc.dart';
import 'package:buty/UI/CustomWidgets/AppLoader.dart';
import 'package:buty/UI/CustomWidgets/CustomBottomSheet.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:buty/UI/CustomWidgets/EmptyItem.dart';
import 'package:buty/UI/CustomWidgets/ErrorDialog.dart';
import 'package:buty/UI/CustomWidgets/LoadingDialog.dart';
import 'package:buty/UI/CustomWidgets/on_done_dialog.dart';
import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'package:buty/UI/bottom_nav_bar/reservations/reservations.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/current_ordera_model.dart';
import 'package:buty/models/general_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:buty/models/current_ordera_model.dart';

class CurrentReservationView extends StatefulWidget {
  @override
  _CurrentReservationViewState createState() => _CurrentReservationViewState();
}

class _CurrentReservationViewState extends State<CurrentReservationView> {
  @override
  void initState() {
    currentOrdersBloc.add(CurrentReservatiosnEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: currentOrdersBloc,
        builder: (context, state) {
      if (state is Loading) {
        return AppLoader();
      } else if (state is Done) {
        var data = state.model as CurrentOrdersResponse;
        if (data.orders == null) {
          return  Padding(
            padding: const EdgeInsets.symmetric(vertical: 150),
            child: Center(
                child: Text(translator.currentLanguage == "en"
                    ? "No Reservations"
                    : "ليس لديك حجوزات منتهية حتي الان")),
          );
        } else {
         return StreamBuilder<CurrentOrdersResponse>(
            stream: currentOrdersBloc.subject,
            builder: (context,snapshot){
              if(snapshot.hasData){
                if (snapshot.data.orders.isEmpty) {
                  return  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 150),
                    child: Center(
                        child: Text(translator.currentLanguage == "en"
                            ? "No Reservations"
                            : "ليس لديك حجوزات منتهية حتي الان")),
                  );
                }else{
                  return AnimationLimiter(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.orders.length,
                      itemBuilder: (BuildContext context, int index) {
                        var duaration=0 ;
                        data.orders[index].services.forEach((element) {
                          duaration += int.parse(element.estimatedTime);
                        });
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

                                         /* Row(
                                            children: [
                                              Text(
                                                  "${translator.translate("Service")} "),
                                              Text(
                                                "${translator.currentLanguage == "ar" ?
                                                data.orders[index].services[0].nameAr : data.orders[index].services[0].nameEn}",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ],
                                          ),*/


                                          services(data.orders[index].services),

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
                                                  "${translator.translate("Duration")} : "),
                                              Text(
                                                " ${duaration} ${translator.translate("Min")}",
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
                                          Row(
                                            children: [
                                              Text(
                                                  "${translator.translate("location")} : "),
                                              Text(
                                                "${ data.orders[index].locationType}",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                  "${translator.translate( "service location price")} : "),
                                              Text(
                                                "${ data.orders[index].locationType == "موقع العميل" || data.orders[index].locationType == "User Address" ?
                                                "100 ${translator.translate("sar")}" : "130 ${translator.translate("sar")}" }",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ],
                                          ),

                              /*            Wrap(
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
                                          ),*/

                                          Row(
                                            children: [
                                              Text(
                                                  "${translator.translate("cost")} "),
                                              Text(
                                                "  ${data.orders[index].cost} ${translator.translate("sar")}",
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
                                                      data.orders[index].id,
                                                      data.orders[index].beautician.id
                                                  ),
                                                  hight: MediaQuery.of(context).size.height / 2.7);
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
                                )
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              }else{
                return AppLoader();
            /*    return  Padding(
                  padding: const EdgeInsets.symmetric(vertical: 150),
                  child: Center(
                      child: Text(translator.currentLanguage == "en"
                          ? "No Reservations"
                          : "ليس لديك حجوزات منتهية حتي الان")),
                );*/
              }

            },
          );
        }
      }else if(state is ErrorLoading){
        return  Padding(
          padding: const EdgeInsets.symmetric(vertical: 150),
          child: Center(
              child: Text(translator.currentLanguage == "en"
                  ? "No Reservations"
                  : "ليس لديك حجوزات منتهية حتي الان")),
        );
      }else{
        return AppLoader();

      }
    });



  }

  Widget cansel(int id,int beautician_id) {
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainPage(index: 2,))
                );
                currentOrdersBloc.add(Hydrate());
              });
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child:  Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child:  Text(
                          translator.translate("validate_cansel"),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )  ),
                    Padding(padding: EdgeInsets.all(10),
                        child:CustomTextField(
                          hint: translator.translate("cancel reason details"),
                          inputType: TextInputType.text,
                          validate: (String val) {
                            if (val.isEmpty) {
                              return translator.translate("cancel reason details");
                            }
                          },
                          lines: 3,
                          value: (String val) {
                            canselOrderbloc.cancel_reason(val);
                          },
                        )  ),
                  ],
                )


            ),
            Row(
              children: [

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
                CustomButton(
                  onBtnPress: () {
                    canselOrderbloc.updateId(id);
                    canselOrderbloc.updateStatus(3);
                    canselOrderbloc.beauticianId(beautician_id);
                    canselOrderbloc.add(Click());
                  },
                  width: MediaQuery.of(context).size.width / 2.8,
                  text: translator.translate("yes"),
                ),
              ],
            )
          ],
        ),
      )
    );
  }

  Widget services(List<Services> services){

    return  Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                 translator.translate('service_name'),
                  style:
                  TextStyle(
                    color: Color(
                        0xFF292929),
                  ),),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Text(
                  translator.translate("service_price"),
                  style:
                  TextStyle(
                    color: Color(
                        0xFF292929),
                  ),),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Text(
                  translator.translate('persons'),
                  style:
                  TextStyle(
                    color: Color(
                        0xFF292929),
                  ),),
              ),
            )
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: services.length,
          itemBuilder: (context, i) {
            return Column(
              children: [
                Container(
                    padding: EdgeInsets.only(
                        right:
                        2,
                        left:
                        2),
                    child:Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(

                                    padding: EdgeInsets.only(right: 10,left: 10),
                                    decoration: BoxDecoration(
                                        color:
                                        Color(0xFFF6F6F6),
                                        borderRadius: BorderRadius.circular(5)),
                                    child:
                                    Text(
                                      '${ services[i].nameAr }',
                                      style: TextStyle(
                                          color: Color(0xFF403E3E),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                )
                                ,
                                SizedBox(width: 5,),
                              ],
                            )
                        ),
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    alignment:
                                    Alignment.center,
                                    decoration: BoxDecoration(
                                        color:
                                        Color(0xFFF6F6F6),
                                        borderRadius: BorderRadius.circular(5)),
                                    child:
                                    Text(
                                      '${services[i].price}  ${translator.translate('sar')}  ',
                                      style: TextStyle(
                                          color: Color(0xFF403E3E),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5,)
                              ],
                            )
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            //   width: MediaQuery.of(context).size.width / 3,
                            alignment:
                            Alignment.center,
                            decoration: BoxDecoration(
                                color:
                                Color(0xFFF6F6F6),
                                borderRadius: BorderRadius.circular(5)),
                            child:
                            Text(
                              '${services[i].personNum}',
                              style: TextStyle(
                                  color: Color(0xFF403E3E),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(height: 5,)
              ],
            );
          },
        ),
      ],
    );
  }
}
