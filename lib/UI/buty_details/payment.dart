import 'package:buty/Base/shared_preference_manger.dart';
import 'package:buty/Bolcs/payment_bloc.dart';
import 'package:buty/Bolcs/user_cards_bloc.dart';
import 'package:buty/UI/bottom_nav_bar/reservations/reservations.dart';
import 'package:buty/UI/buty_details/chosse_payment_card.dart';
import 'package:buty/UI/buty_details/payment_web_view.dart';
import 'package:buty/models/create_order_model.dart';
import 'package:buty/models/user_credit_cards_model.dart';
import 'package:buty/repo/payment_repo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:buty/Bolcs/creat_order_bloc.dart';
import 'package:buty/Bolcs/my_address_bloc.dart';
import 'package:buty/Bolcs/mycards_bloc.dart';
import 'package:buty/UI/CustomWidgets/AppLoader.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:buty/UI/CustomWidgets/EmptyItem.dart';
import 'package:buty/UI/CustomWidgets/ErrorDialog.dart';
import 'package:buty/UI/CustomWidgets/LoadingDialog.dart';
import 'package:buty/UI/CustomWidgets/on_done_dialog.dart';
import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/AllPaymentMethodsResponse.dart';
import 'package:buty/models/general_response.dart';
import 'package:buty/models/my_address.dart';
import 'package:buty/models/my_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentScreen extends StatefulWidget {
  final List<MyList> servicseList;
  final bool address;
  final String total;

  const PaymentScreen({Key key, this.servicseList, this.address, this.total})
      : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int time = 0;
  int total_duration = 0;
  var card_id;
  String cvv;
  TextEditingController cvv_controller;

  void getmyAddress() {
    if (widget.address == true) {
      createOrderBloc.updateLocationType(1);
      myAdressBloc.add(Hydrate());
    } else {
      createOrderBloc.updateLocationType(0);
      print("Location ====> Butican Plase");
    }

    for (int i = 0; i < widget.servicseList.length; i++) {
      print(widget.servicseList[i].estimatedTime);
      setState(() {
        time = widget.servicseList[i].count *
            int.parse(widget.servicseList[i].estimatedTime);
      });
      total_duration += time;
    }
    print("total_duration : ${total_duration}");
  }

  @override
  void initState() {
    getmyAddress();
    allCardsBloc.add(Hydrate());
    usercards_bloc.add(Hydrate());
    cvv_controller = new TextEditingController();
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
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainPage(
                                    index: 0,
                                  )));
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    )),
              )
            ],
            centerTitle: true,
            title: Text(
              translator.translate("payment"),
              style: TextStyle(color: Colors.white, fontSize: 14),
            )),
        body: BlocListener(
          bloc: createOrderBloc,
          listener: (context, state) {
            var data = state.model as CreateOrderModel;
            if (state is Loading) {
              showLoadingDialog(context);
            }
            if (state is ErrorLoading) {
              Navigator.of(context).pop();
              errorDialog(
                  context: context,
                  text: data.msg,
                  function: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MainPage()));
                  });
            }
            if (state is Done) {
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;
              print("create order done");
              print("order_id : ${data.order.id}");
              print("cost : ${data.order.cost}");
              print("user_id : ${data.order.userId}");

              if(data.order.paymentMethodId == 1) { // use credit card

                paymentRepo.hyperpay_payment(
                    order_id: data.order.id,
                    amount: data.order.cost,
                    user_id: data.order.userId,
                    context: context);
              }else if(data.order.paymentMethodId == 2) { // use Apple Pay

                paymentRepo.hyperpay_payment(
                    order_id: data.order.id,
                    amount: data.order.cost,
                    user_id: data.order.userId,
                    context: context);
              }
              else if (data.order.paymentMethodId == 3) { // use Cash
                onDoneDialog(
                    context: context,
                    text: data.msg,
                    function: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(
                              index: 2,
                            ),
                          ),
                          (Route<dynamic> route) => false);
                    });
              }
            }
          },
          child: BlocBuilder(
            bloc: createOrderBloc,
            builder: (context, state) {
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                children: [
                  Text(
                    translator.translate("services"),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.servicseList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${translator.translate("service_name")}  :  ${widget.servicseList[index].nameAr}",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${translator.translate("persons")}  :  ${widget.servicseList[index].count}  ",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${widget.servicseList[index].price} ${translator.translate("sar")}  ",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        "${widget.servicseList[index].estimatedTime} ${translator.translate("min")} ",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Divider()
                            ],
                          ),
                        );
                      }),
                  Text(
                    translator.translate("address"),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  widget.address == false
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/car.png",
                                      width: 25,
                                      height: 25,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    translator.translate("at_buty"),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    "100 ${translator.translate("sar")}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : BlocListener<MyAdressBloc, AppState>(
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
                                          text: data.msg,
                                        ))
                                      : AnimationLimiter(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: data.locations.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return AnimationConfiguration
                                                  .staggeredList(
                                                position: index,
                                                duration: const Duration(
                                                    milliseconds: 375),
                                                child: SlideAnimation(
                                                    verticalOffset: 50.0,
                                                    child: FadeInAnimation(
                                                        child: address_item(
                                                            data, index))),
                                              );
                                            },
                                          ),
                                        );
                            },
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translator.translate("copoun"),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: CustomTextField(
                            hint: translator.translate("enter_copoun"),
                            inputType: TextInputType.text,
                            value: (String val) {
                              createOrderBloc.updateCopone(val);
                            },
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translator.translate("duration"),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Center(
                        child: Text(
                            "${total_duration} ${translator.translate("min")}"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.calendar_today,
                          color: Theme.of(context).primaryColor),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        translator.translate("date"),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Center(
                        child: Text("${createOrderBloc.date.value.toString()}"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.access_time,
                          color: Theme.of(context).primaryColor),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        translator.translate("time"),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Center(
                        child: Text(createOrderBloc.time.value.toString()),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.money_off,
                          color: Theme.of(context).primaryColor),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        translator.translate("total"),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Center(
                        child: Text(
                            "${widget.total}   ${translator.translate("sar")}"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    translator.translate("pay_method"),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  BlocListener<AllCardsBloc, AppState>(
                    bloc: allCardsBloc,
                    listener: (context, state) {},
                    child: BlocBuilder(
                      bloc: allCardsBloc,
                      builder: (context, state) {
                        var data = state.model as PaymentMethodsResponse;
                        return data == null
                            ? AppLoader()
                            : data.paymentMethods.isEmpty
                                ? Center(
                                    child: EmptyItem(
                                    text: data.msg ?? "No Added Credit Cards",
                                  ))
                                : paymentMethods(data);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      List<int> _services = [];
                      List<int> persons = [];
                      for (int i = 0; i < widget.servicseList.length; i++) {
                        _services.add(widget.servicseList[i].id);
                        persons.add(widget.servicseList[i].count);
                      }
                      print(_services);
                      print(persons);
                      createOrderBloc.updateServices(_services);
                      createOrderBloc.updatePersonNumber(persons);
                      createOrderBloc.add(Click());
                    },
                    child: CustomButton(
                      text: translator.translate("pay_now"),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget paymentMethods(PaymentMethodsResponse data) {
    return AnimationLimiter(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: data.paymentMethods.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: InkWell(
                onTap: () {
                  for (int i = 0; i < data.paymentMethods.length; i++) {
                    setState(() {
                      data.paymentMethods[i].isSellected = i == index;
                    });
                  }
                  print("Sellected Id ==== > ${data.paymentMethods[index].id}");

/*                  data.paymentMethods[index].id != 3
                      ? showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                contentPadding: EdgeInsets.all(0.0),
                                content: Directionality(
                                    textDirection:
                                        translator.currentLanguage == 'ar'
                                            ? TextDirection.rtl
                                            : TextDirection.ltr,
                                    child: Container(
                                        child: Expanded(
                                            child: user_cards_widget()))));
                          })
                      : null;*/

                  createOrderBloc.updatePaymentMethod(data.paymentMethods[index].id);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          translator.currentLanguage == "ar"
                              ? data.paymentMethods[index].nameAr
                              : data.paymentMethods[index].nameEn,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      data.paymentMethods[index].isSellected == false
                          ? Icon(Icons.check_circle_outline,
                              color: Theme.of(context).primaryColor)
                          : Icon(Icons.check_circle,
                              color: Theme.of(context).primaryColor)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget address_item(MyAddressResponse data, int index) {
    return InkWell(
      onTap: () {
        for (int i = 0; i < data.locations.length; i++) {
          setState(() {
            data.locations[i].isSellected = i == index;
          });
        }
        print("Sellected Id ==== > ${data.locations[index].id}");
        createOrderBloc.updateLocationId(data.locations[index].id);
      },
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(Icons.location_on, color: Theme.of(context).primaryColor),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "${data.locations[index].address}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ]),
            data.locations[index].isSellected == false
                ? Icon(Icons.check_circle_outline,
                    color: Theme.of(context).primaryColor)
                : Icon(Icons.check_circle,
                    color: Theme.of(context).primaryColor)
          ]),
          Divider()
        ],
      ),
    );
  }

  Widget user_cards_widget() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder(
      bloc: usercards_bloc,
      builder: (context, state) {
        var data = state.model as UserCreditCardModel;
        return data == null
            ? AppLoader()
            : data.cards == null
                ? Center(
                    child: EmptyItem(
                    text: data.msg == "الرمز المميز غير موجود"
                        ? "عفواً يرجي تسجيل الدخول اولاًً "
                        : data.msg == "الرمز المميز غير موجود"
                            ? "Authorization Token Not Found"
                            : "Sorry You Must Log In First",
                  ))
                : AnimationLimiter(
                    child: ListView.builder(
                        itemCount: data.cards.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, indexx) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: width * 0.01, bottom: width * 0.01),
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        card_id = data.cards[indexx].id;
                                        sharedPreferenceManager.writeData(
                                            CachingKey.CARD_ID, card_id);
                                        print("card_id : ${card_id}");
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(height * .02),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Image.asset(
                                                    "assets/images/master_card.png",
                                                    width: 25,
                                                    height: 25,
                                                  )),
                                              Expanded(
                                                  flex: 4,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "${data.cards[indexx].holderName}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 30),
                                                        child: Text(
                                                          "${data.cards[indexx].number}",
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Expanded(
                                                flex: 1,
                                                child: InkWell(
                                                    onTap: () {},
                                                    child: card_id ==
                                                            data.cards[indexx]
                                                                .id
                                                        ? Icon(
                                                            Icons.check_circle,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            size: 20,
                                                          )
                                                        : Icon(
                                                            Icons.check_circle,
                                                            color: Colors.grey,
                                                            size: 20,
                                                          )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                              Divider(
                                color: Colors.grey,
                                height: 2,
                              )
                            ],
                          );
                        }),
                  );
      },
    );
  }

  Widget cvvTextField() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: height * .07,
          width: width * .65,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(height * .1)),
          child: TextFormField(
            controller: cvv_controller,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.grey, fontSize: 14),
            obscureText: false,
            textAlign: translator.currentLanguage == 'ar'
                ? TextAlign.right
                : TextAlign.left,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              hintText: "Enter CVV *",
              hintStyle: TextStyle(
                color: Color(0xffA0AEC0).withOpacity(
                  .8,
                ),
                fontSize: height * .018,
              ),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(height * .1),
                  borderSide:
                      BorderSide(color: Colors.grey, width: height * .002)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(height * .1),
                  borderSide:
                      BorderSide(color: Colors.grey, width: height * .002)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(height * .1),
                  borderSide:
                      BorderSide(color: Colors.grey, width: height * .002)),
            ),
          ),
        ),
      ],
    );
  }
}
