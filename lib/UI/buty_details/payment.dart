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
        time = time + int.parse(widget.servicseList[i].estimatedTime);
      });
      print(time);
    }
  }

  @override
  void initState() {
    getmyAddress();
    allCardsBloc.add(Hydrate());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translator.currentLanguage=="ar"?TextDirection.rtl :TextDirection.ltr,

      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
            centerTitle: true,
            title: Text(
              translator.translate("payment"),
              style: TextStyle(color: Colors.white, fontSize: 14),
            )),
        body: BlocListener(
          bloc: createOrderBloc,
          listener: (context, state) {
            var data = state.model as GeneralResponse;
            if (state is Loading) {
              showLoadingDialog(context);
            }
            if (state is ErrorLoading) {
              Navigator.of(context).pop();
              errorDialog(
                context: context,
                text: data.msg,
              );
            }
            if (state is Done) {
              onDoneDialog(
                  context: context,
                  text: data.msg,
                  function: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(index: 2,),
                        ),
                        (Route<dynamic> route) => false);
                  });
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${translator.translate("service_name")}  :  ${translator == "ar" ? widget.servicseList[index].nameAr : widget.servicseList[index].nameEn}",
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    translator.translate("at_buty"),
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    "100 ريال",
                                    style: TextStyle(fontWeight: FontWeight.bold),
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
                            inputType: TextInputType.number,
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
                        child: Text("${time} ${translator.translate("min")}"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translator.translate("date"),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Center(
                        child:
                            Text("${DateTime.now().toString().substring(0, 10)}"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translator.translate("time"),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Center(
                        child: Text("10 Pm"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translator.translate("total"),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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
                  createOrderBloc
                      .updatePaymentMethod(data.paymentMethods[index].id);
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
              Icon(Icons.location_on,
                  color: Theme.of(context).primaryColor),
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
}
