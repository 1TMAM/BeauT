import 'package:buty/UI/side_menu/cards/edit_card.dart';
import 'package:buty/models/AllPaymentMethodsResponse.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class CriditCardSingleItem extends StatelessWidget {
  final Cards card;

  const CriditCardSingleItem({Key key, this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(
                children: [
                  Image.asset(
                    "assets/images/master_card.png",
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${card.holderName}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditCard(
                                card: card,
                              )));
                },
                child: Text(
                  translator.translate("edit"),
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "${card.number}",
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
