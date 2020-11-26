import 'package:buty/Bolcs/add_new_locatoin.dart';
import 'package:buty/UI/CustomWidgets/AppLoader.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:buty/UI/CustomWidgets/ErrorDialog.dart';
import 'package:buty/UI/CustomWidgets/LoadingDialog.dart';
import 'package:buty/UI/CustomWidgets/on_done_dialog.dart';
import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'package:buty/UI/side_menu/address/myAddress.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/general_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AddNewLocation extends StatefulWidget {
  @override
  _AddNewLocationState createState() => _AddNewLocationState();
}

class _AddNewLocationState extends State<AddNewLocation> {
  double currentLat;
  double currentLong;
  String userLocation;
  Position updatedPosition;
  bool isloading = true;

  GlobalKey<FormState> key = GlobalKey();

  @override
  void initState() {
    _getAddress();
    super.initState();
  }

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
            translator.translate("add_new_location"),
            style: TextStyle(color: Colors.white, fontSize: 14),
          )),
      body: BlocListener(
        bloc: addNewAddressBloc,
        listener: (context, state) {
          var date = state.model as GeneralResponse;
          if (state is Loading) {
            showLoadingDialog(context);
          }
          if (state is ErrorLoading) {
            Navigator.pop(context);
            errorDialog(context: context, text: date.msg);
          }
          if (state is Done) {
            Navigator.pop(context);
            onDoneDialog(
                context: context,
                text: date.msg,
                function: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyAddresses()));
                });
          }
        },
        child: Form(
          key: key,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            children: [
              Text(
                translator.translate("choose_from_map"),
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
                      translator.translate("location_details"),
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              CustomTextField(
                validate: (String val) {
                  if (val.isEmpty) {
                    return translator.translate("complete_data");
                  }
                },
                value: (String val) {
                  addNewAddressBloc.updateAddress(val);
                },
                hint: "        ",
              ),
              isloading == true
                  ? AppLoader()
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width - 50,
                        child: Stack(
                          children: <Widget>[
                            GoogleMap(
                              onCameraIdle: () {
                                print(updatedPosition);
                              },
                              onTap: (newLang) {
                                currentLat = updatedPosition.latitude;
                                currentLong = updatedPosition.longitude;
                                print('LAT    ' + currentLat.toString());
                                print('LONG    ' + currentLong.toString());
                              },
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(currentLat, currentLong),
                                  zoom: 15.0),
                              onCameraMove: ((_position) =>
                                  _updatePosition(_position)),
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: Icon(Icons.location_on,
                                    color: Theme.of(context).primaryColor,
                                    size: 40)),
                          ],
                        ),
                      ),
                    ),
              InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyAddresses())),
                child: CustomButton(
                  onBtnPress: () {
                    if (!key.currentState.validate()) {
                      return;
                    } else {
                      addNewAddressBloc.updateLat(currentLat);
                      addNewAddressBloc.updateLong(currentLong);
                      addNewAddressBloc.add(Click());
                    }
                  },
                  text: translator.translate("add"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Set<Marker> mark = Set();
  Marker marker = Marker(
    markerId: MarkerId("1"),
  );

  _getAddress() async {
    Position position = await Geolocator().getCurrentPosition();
    setState(() {
      currentLat = position.latitude;
      currentLong = position.longitude;
    });

    print("LAAAAAAAAAAAAAAAAAAAAAAAAAAT" + currentLat.toString());
    print("LNNNNNNNNNNNNNNNNNNNNNNNNNNG" + currentLong.toString());

    setState(() {
      isloading = false;
    });
  }

  void _updatePosition(CameraPosition _position) {
    Position newMarkerPosition = Position(
        latitude: _position.target.latitude,
        longitude: _position.target.longitude);
    setState(() {
      updatedPosition = newMarkerPosition;
      currentLat = newMarkerPosition.latitude;
      currentLong = newMarkerPosition.longitude;
      marker = marker.copyWith(
          positionParam:
              LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));
      Geolocator()
          .placemarkFromCoordinates(
              updatedPosition.latitude, updatedPosition.longitude)
          .then((address) {
        setState(() {
          userLocation = address[0].name + "  " + address[0].country;
          print("================== $userLocation");
        });
      });
    });
  }
}
