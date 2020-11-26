import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:buty/Bolcs/add_new_card_bloc.dart';
import 'package:buty/UI/CustomWidgets/CustomBottomSheet.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:buty/UI/CustomWidgets/ErrorDialog.dart';
import 'package:buty/UI/CustomWidgets/LoadingDialog.dart';
import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'package:buty/UI/side_menu/cards/my_cards.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/general_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewCard extends StatefulWidget {
  @override
  _AddNewCardState createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  String card_num = "123456789";

  String cardHolder = "Enter your Name";

  String cvv = "1234";
  GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
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
             translator.translate("add_new_card"),
            style: TextStyle(color: Colors.white, fontSize: 14),
          )),
      body: BlocListener(
        bloc: addCreditCardBloc,
        listener: (context, state) {
          var data = state.model as GeneralResponse;
          if (state is Loading) {
            showLoadingDialog(context);
          } else if (state is ErrorLoading) {
            Navigator.pop(context);
            errorDialog(text: data.msg, context: context);
          } else if (state is Done) {
            Navigator.pop(context);
            CustomSheet(
                context: context,
                widget: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        width: 60,
                        height: 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Text( translator.translate("done_add_card")),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Icon(
                        Icons.check_circle,
                        size: 125,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyCards()));
                      },
                      child: CustomButton(
                        text:  translator.translate("back"),
                      ),
                    )
                  ],
                ));
          }
        },
        child: BlocBuilder(
          bloc: addCreditCardBloc,
          builder: (context, state) {
            return Form(
              key: key,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    exampleContainer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text( translator.translate("card_number")),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomTextField(
                        validate: (String val) {
                          if (val.length < 16) {
                            return "Complete Data";
                          }
                        },
                        hint: card_num,
                        inputType: TextInputType.number,
                        value: (String val) {
                          setState(() {
                            card_num = val;
                          });
                          print(val);
                          addCreditCardBloc.updateNumber(val);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text( translator.translate("expireDate")),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: CustomTextField(
                                    validate: (String val) {
                                      if (val.length < 5) {
                                        return "Complete Data";
                                      }
                                    },
                                    hint: "02/20",
                                    inputType: TextInputType.number,
                                    value: (String val) {
                                      setState(() {
                                        cvv = val;
                                      });
                                      print(val);
                                      addCreditCardBloc.updateDate(val);
                                    },
                                  )),
                            ],
                          ),
                          Column(
                            children: [
                              Text("CVV"),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: CustomTextField(
                                    hint: "CVV",
                                    inputType: TextInputType.number,
                                    validate: (String val){
                                      if(val.length <3){
                                        return "يرجي اكمال البيانات";
                                      }
                                    },
                                    value: (String val) {

                                      setState(() {
                                        cvv = val;
                                      });
                                      print(val);
                                      addCreditCardBloc.updateCvv(val);
                                    },
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text( translator.translate("card_holder")),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomTextField(
                        hint: "User Name",
                        validate: (String val){
                          if(val.isEmpty){
                            return "يرجي اكمال البيانات";
                          }
                        },
                        value: (String val) {
                          setState(() {
                            cardHolder = val;
                          });
                          print(val);
                          addCreditCardBloc.updateName(val);
                        },
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          if (!key.currentState.validate()) {
                            return;
                          } else {
                            addCreditCardBloc.add(Click());
                          }
                        },
                        child: CustomButton(
                          text: "${ translator.translate("add")}",
                        )),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget exampleContainer() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Card(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(card_num),
                      Image.asset(
                        "assets/images/master_card.png",
                        width: 25,
                        height: 25,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("CVV"),
                      Text("Expire Date"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(cvv),
                      Text("${DateTime.now().toString().substring(0, 10)}"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(cardHolder),
              ],
            ),
          ),
        ),
      ),
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
    );
  }
}
