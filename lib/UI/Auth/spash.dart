import 'dart:async';

import 'package:buty/Base/Notifications.dart';
import 'package:buty/Base/shared_preference_manger.dart';
import 'package:geocoder/geocoder.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:location/location.dart';

import '../CustomWidgets/app_logo.dart';
import 'choose_languae.dart';

class Splash extends StatefulWidget {
  final GlobalKey navKey;

  const Splash({Key key, this.navKey}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var mSharedPreferenceManager = SharedPreferenceManager();
  final GlobalKey<NavigatorState> navKey = GlobalKey();
  AppPushNotifications appPushNotifications = AppPushNotifications();
  @override
  void initState() {
    setState(() {
      appPushNotifications.notificationSetup(navKey);
    });
    _loadData();
    super.initState();
  }

  var isLogged;
  var token;

  Future<Timer> _loadData() async {
    isLogged =
        await sharedPreferenceManager.readBoolean(CachingKey.IS_LOGGED_IN);
    token = await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(isLogged);
    print(token);

    return new Timer(Duration(seconds: 4), _onDoneLoading);
  }

  _onDoneLoading() async {
    if(isLogged){
      getUserLocation();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainPage(),
          ),
              (Route<dynamic> route) => false);
    }else{
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Languages(),
          ),
              (Route<dynamic> route) => false);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: AnimationConfiguration.staggeredList(
          position: 1,
          duration: Duration(seconds: 3),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: AppLogo(
                hight: 50,
                width: 50,
              ),
            ),
          ),
        ),
      ),
    );
  }



  static Future<void> getUserLocation() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    final Location location = Location();
    String _error;
    try {
      await location.requestService();
      final LocationData _locationResult = await location.getLocation();
      final coordinates = new Coordinates(
          _locationResult.latitude, _locationResult.longitude);
      mSharedPreferenceManager.writeData(CachingKey.USER_LAT, _locationResult.latitude);
      mSharedPreferenceManager.writeData(CachingKey.USER_LONG, _locationResult.longitude);

    } catch (err) {
      _error = err.code;
    }
  }
}
