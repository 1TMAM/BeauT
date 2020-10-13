import 'dart:async';

import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'package:buty/UI/side_menu/add_address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddNewLocation extends StatefulWidget {
  @override
  _AddNewLocationState createState() => _AddNewLocationState();
}

class _AddNewLocationState extends State<AddNewLocation> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.774265, 46.738586),
    zoom: 14.4746,
  );

  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(24.774265, 46.738586),
  //     tilt: 59.440717697143555,
  //     zoom: 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            allTranslations.text("add_new_location"),
            style: TextStyle(color: Colors.white, fontSize: 14),
          )),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        children: [
          Text(
            allTranslations.text("choose_from_map"),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Icon(
                Icons.location_on,
                size: 25,
                color: Theme.of(context).primaryColor,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  allTranslations.text("location_details"),
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          CustomTextField(
            hint: "        ",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10 ),
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width - 50,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ),
          InkWell(
            onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>MyAddresses())),
            child: CustomButton(
              text: allTranslations.text("add"),
            ),
          )
        ],
      ),
    );
  }
}
