import 'dart:async';

import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/helpers/shared_preference_manger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../CustomWidgets/app_logo.dart';
import 'choose_languae.dart';

class Splash extends StatefulWidget {
  final GlobalKey navKey;

  const Splash({Key key, this.navKey}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final String language = allTranslations.currentLanguage;

  @override
  void initState() {
    print(language);
    _loadData();
    super.initState();
  }

  String token;

  Future<Timer> _loadData() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    token = await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    return new Timer(Duration(seconds: 4), _onDoneLoading);
  }

  _onDoneLoading() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Languages(),
        ),
        (Route<dynamic> route) => false);
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
}
