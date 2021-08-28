
import 'package:buty/Bolcs/mycards_bloc.dart';
import 'package:buty/Bolcs/user_cards_bloc.dart';
import 'package:buty/UI/CustomWidgets/AppLoader.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/EmptyItem.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/models/AllPaymentMethodsResponse.dart';
import 'package:buty/models/user_credit_cards_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class PaymentMethodsDialog extends StatefulWidget {
  final String route;
  final int amount;
  final BuildContext context;
  PaymentMethodsDialog({this.route, this.amount, this.context});

  @override
  State<StatefulWidget> createState() {
    print("---amount --- : ${amount}");
    // TODO: implement createState
    return PaymentMethodsDialogState();
  }
}

class PaymentMethodsDialogState extends State<PaymentMethodsDialog>
    with TickerProviderStateMixin {
  var card_id;

  @override
  void initState() {
    usercards_bloc.add(Hydrate());

    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: StatefulBuilder(
        builder: (context, setState) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return AlertDialog(
              contentPadding: EdgeInsets.all(0.0),
              content: Directionality(
                  textDirection: translator.currentLanguage == 'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: Container(child: Expanded(child: buildBody()))));
        },
      ),
    );
  }

  Widget buildBody() {
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
              physics:
              NeverScrollableScrollPhysics(),
              itemBuilder: (context, indexx) {
                return  InkWell(
                    onTap: () {
                      setState(() {
                        card_id = data.cards[indexx].id;
                        print("card_id : ${card_id}");
                       // Navigator.pop(context);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color:
                        card_id == indexx ? Colors.green.withOpacity(.2) : Colors.white,
                        border: Border.all(
                            color: card_id == indexx ? Colors.green.withOpacity(.2) : Colors.white),
                        borderRadius: BorderRadius.all(
                          Radius.circular(height * .02),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex:1,
                                  child: Image.asset(
                                    "assets/images/master_card.png",
                                    width: 25,
                                    height: 25,
                                  )),
                              Expanded(
                                  flex:4,
                                  child:Column(
                                    children: [
                                      Text(
                                        "${data.cards[indexx].holderName}",
                                        style: TextStyle(
                                            fontWeight:
                                            FontWeight
                                                .bold,
                                            fontSize:
                                            15),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets
                                            .symmetric(
                                            horizontal:
                                            30),
                                        child: Text(
                                          "${data.cards[indexx].number}",
                                          style: TextStyle(
                                              fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ) ),
                              Expanded(
                                flex:1,
                                child: InkWell(
                                  onTap: () {

                                  },
                                  child: Text(
                                    translator
                                        .translate(
                                        "edit"),
                                    style: TextStyle(
                                        fontSize:
                                        13),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ) );



              }),
        );
      },
    );
  }


}
