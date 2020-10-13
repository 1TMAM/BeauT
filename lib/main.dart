import 'package:buty/Base/Translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Base/AllTranslation.dart';
import 'UI/Auth/spash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await allTranslations.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static restartApp(BuildContext context) {
    final _MyAppState state =
        context.ancestorStateOfType(const TypeMatcher<_MyAppState>());
    state.restartApp();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();

  void restartApp() {
    this.setState(() {
      key = new UniqueKey();
    });
  }

  final GlobalKey<NavigatorState> navKey = GlobalKey();

  // AppPushNotifications appPushNotifications = AppPushNotifications();
  //
  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     appPushNotifications.notificationSetup(navKey);
  //   });
  //   Future<PermissionStatus> permissionStatus =
  //   NotificationPermissions.getNotificationPermissionStatus();
  //   permissionStatus.then((status) {
  //     print("======> $status");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale(allTranslations.currentLanguage),
      supportedLocales: allTranslations.supportedLocales(),
      localizationsDelegates: [
        TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      navigatorKey: navKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //------------------make iphone back with swipe-----------------
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
        //---------------------------------------------------------------
        primaryColor: Color(0xFFDBB2D2),
        fontFamily: 'Cairo',
      ),
      home: Splash(
        navKey: navKey,
      ),
    );
  }
}
