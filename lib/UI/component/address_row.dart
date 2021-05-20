import 'package:buty/UI/side_menu/address/EditAddresa.dart';
import 'package:buty/models/my_address.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AddressRow extends StatelessWidget {
  final Locations address;

  const AddressRow({Key key, this.address}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Theme.of(context).primaryColor,
                  size: 25,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${address.address}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                print("id : ${address.id}");
                print("address : ${address.address}");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditAddress(
                              id: address.id,
                              name: address.address,
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
            "${address.createdAt}",
            style: TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
