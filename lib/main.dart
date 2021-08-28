
import 'package:buty/Base/Notifications.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:notification_permissions/notification_permissions.dart';

import 'UI/Auth/spash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await translator.init(
    assetsDirectory: 'assets/langs/',
    languagesList: ['ar','en']
  );

  runApp(LocalizedApp(child: MyApp()));
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType();
    print(newLocale.languageCode);
    // ignore: invalid_use_of_protected_member
    state.setState(() => state.local = newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale local;
  final GlobalKey<NavigatorState> navKey = GlobalKey();
  AppPushNotifications appPushNotifications = AppPushNotifications();

  @override
  void initState() {

    setState(() {
      appPushNotifications.notificationSetup(navKey);
    });
    Future<PermissionStatus> permissionStatus =
    NotificationPermissions.getNotificationPermissionStatus();
    permissionStatus.then((status) {
      print("======> $status");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: translator.delegates,
      locale: local,
      supportedLocales: translator.locals(),
      navigatorKey: navKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //------------------ make iphone  back  with swipe -----------------
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
        //---------------------------------------------------------------
        primaryColor: Color(0xFFDBB2D2),
        scaffoldBackgroundColor: Colors.white,
        fontFamily:translator.currentLanguage=="en"? 'Elmessiri':'Cairo',
      ),
      home: Splash(
        navKey: navKey,
      ),
    );
  }
}
