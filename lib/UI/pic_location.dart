import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/Bolcs/search_by_address_bloc.dart';
import 'package:buty/UI/SearchResult.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/search_by_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:location/location.dart';

import 'CustomWidgets/ErrorDialog.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  BitmapDescriptor myIcon;
  GoogleMapController myController;
  double currentLat;
  double currentLong;

//  dynamic currentAddress;
  String searchAddress = 'Search with Locations';
  String userLocation;
  Marker marker = Marker(
    markerId: MarkerId("1"),
  );
  Set<Marker> mark = Set();

  var location = Location();

  _getAddress() async {
    Position position = await Geolocator().getCurrentPosition();
    setState(() {
      currentLat = position.latitude;
      currentLong = position.longitude;
    });
    Geolocator()
        .placemarkFromCoordinates(currentLat, currentLong)
        .then((address) {
      setState(() {
        userLocation = address[0].subAdministrativeArea +
            "-" +
            address[0].administrativeArea;
      });
    });
    print("LAAAAAAAAAAAAAAAAAAAAAAAAAAT" + currentLat.toString());
    print("LNNNNNNNNNNNNNNNNNNNNNNNNNNG" + currentLong.toString());
  }

  void initState() {
    _getAddress();
    super.initState();
    location.getLocation().then((LocationData myLocation) {
      setState(() {
        Geolocator()
            .placemarkFromCoordinates(myLocation.latitude, myLocation.longitude)
            .then((address) {
          setState(() {
            userLocation = address[0].name + " " + address[0].country;
            print("================== $userLocation");
          });
        });
        currentLat = myLocation.latitude;
        currentLong = myLocation.longitude;

        InfoWindow infoWindow = InfoWindow(title: "Location");
        Marker marker = Marker(
          draggable: true,
          markerId: MarkerId('markers.length.toString()'),
          infoWindow: infoWindow,
          position: LatLng(myLocation.latitude, myLocation.longitude),
          icon: myIcon,
        );
        setState(() {
          mark.add(marker);
        });
      });
    });
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        size: Size(
          20,
          20,
        ),
        devicePixelRatio: 0,
      ),
      'assets/images/marker.png',
    ).then((onValue) {
      myIcon = onValue;
    });
  }

  Widget _confirmButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 50,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Theme.of(context).primaryColor,
        ),
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            translator.translate("done"),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      myController = controller;
    });
  }

  Position updatedPosition;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios ,color: Colors.white,)),
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            translator.translate("choose_location"),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.ltr,
          child: currentLat == null && currentLong == null
              ? Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/loader.gif"))),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
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
                        onMapCreated: _onMapCreated,
                        onCameraMove: ((_position) =>
                            _updatePosition(_position)),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Icon(Icons.location_on,
                              color: Theme.of(context).primaryColor, size: 40)
//                  Image(
//                    image: AssetImage("assets/images/marker.png"),
//                    height: 40,
//                    width: 40,
//                  ),
                          ),

                      // _buildSearch(),
                      currentLat == null ||
                              currentLong == null ||
                              userLocation == null
                          ? SizedBox()
                          : Align(
                              alignment: Alignment.bottomCenter,
                              child: BlocListener(
                                bloc: searchByAddressBloc,
                                listener: (context, state) {
                                  var data =
                                      state.model as SearchByCategoryResponse;

                                  if (state is ErrorLoading) {
                                    Navigator.of(context).pop();
                                    errorDialog(
                                      context: context,
                                      text: data.msg,
                                    );
                                  } else if (state is Done) {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SearchResult(
                                                  beauticianServices: data.data
                                                              .beauticianServices ==
                                                          null
                                                      ? null
                                                      : data.data
                                                          .beauticianServices,
                                                )));
                                  }
                                },
                                child: InkWell(
                                    onTap: () async {
                                      print(userLocation.toString());
                                      searchByAddressBloc.add(Click());
                                    },
                                    child: _confirmButton(context)),
                              ),
                            ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void _updatePosition(CameraPosition _position) {
    Geolocator()
        .placemarkFromCoordinates(
            updatedPosition.latitude, updatedPosition.longitude)
        .then((address) {
      userLocation = address[0].name + "  " + address[0].country;
      print("================== $userLocation");
      searchByAddressBloc.updateAddress(userLocation);
    });
  }

  searchAndNavigate() {
    Geolocator().placemarkFromAddress(searchAddress).then((result) {
      myController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(result[0].position.latitude, result[0].position.longitude),
          zoom: 10.0)));
    });
  }
}
