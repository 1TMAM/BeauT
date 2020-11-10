import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/Bolcs/editCardBloc.dart';
import 'package:buty/UI/CustomWidgets/CustomBottomSheet.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:buty/UI/CustomWidgets/ErrorDialog.dart';
import 'package:buty/UI/CustomWidgets/LoadingDialog.dart';
import 'package:buty/UI/side_menu/cards/my_cards.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/AllPaymentMethodsResponse.dart';
import 'package:buty/models/general_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCard extends StatefulWidget {
  final Cards card;

  const EditCard({Key key, this.card}) : super(key: key);

  @override
  _EditCardState createState() => _EditCardState();
}

class _EditCardState extends State<EditCard> {
  String card_num;
  String cardHolder;
  String cvv;

  @override
  void initState() {
    editCardBloc.updateId(widget.card.id);
    setState(() {
      card_num = widget.card.number.toString();
      cardHolder = widget.card.holderName.toString();
      cvv = widget.card.cvv.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyCards()));
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          centerTitle: true,
          title: Text(
            allTranslations.text("add_new_card"),
            style: TextStyle(color: Colors.white, fontSize: 14),
          )),
      body: BlocListener(
        bloc: editCardBloc,
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
                    Text(allTranslations.text("done_add_card")),
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
                        text: allTranslations.text("back"),
                      ),
                    )
                  ],
                ));
          }
        },
        child: BlocBuilder(
          bloc: editCardBloc,
          builder: (context, state) {
            return ListView(
              children: [
                exampleContainer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(allTranslations.text("card_number")),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomTextField(
                    hint: widget.card.number.toString(),
                    inputType: TextInputType.number,
                    value: (String val) {
                      setState(() {
                        card_num = val;
                      });
                      print(val);
                      editCardBloc.updateNumber(val);
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
                          Text(allTranslations.text("expireDate")),
                          Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: CustomTextField(
                                hint: "${widget.card.expDate}",
                                inputType: TextInputType.number,
                                value: (String val) {
                                  setState(() {
                                    cvv = val;
                                  });
                                  print(val);
                                  editCardBloc.updateDate(val);
                                },
                              )),
                        ],
                      ),
                      Column(
                        children: [
                          Text("CVV"),
                          Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: CustomTextField(
                                hint: "${widget.card.cvv}",
                                inputType: TextInputType.number,
                                value: (String val) {
                                  setState(() {
                                    cvv = val;
                                  });
                                  print(val);
                                  editCardBloc.updateCvv(val);
                                },
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(allTranslations.text("card_holder")),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomTextField(
                    hint: "User Name",
                    value: (String val) {
                      setState(() {
                        cardHolder = val;
                      });
                      print(val);
                      editCardBloc.updateName(val);
                    },
                  ),
                ),
                InkWell(
                    onTap: () {
                      editCardBloc.add(Click());
                    },
                    child: CustomButton(
                      text: "${allTranslations.text("add")}",
                    )),
              ],
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
                      Text("${widget.card.expDate}"),
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
