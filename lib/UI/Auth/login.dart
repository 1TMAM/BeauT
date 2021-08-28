import 'package:buty/Base/Notifications.dart';
import 'package:buty/Base/shared_preference_manger.dart';
import 'package:geocoder/geocoder.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:buty/Bolcs/loginBloc.dart';
import 'package:buty/UI/Auth/forget_password.dart';
import 'package:buty/UI/Auth/sign_up.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:buty/UI/CustomWidgets/ErrorDialog.dart';
import 'package:buty/UI/CustomWidgets/LoadingDialog.dart';
import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
 class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translator.currentLanguage=="ar"?TextDirection.rtl :TextDirection.ltr,

      child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Image.asset(
                "assets/images/header.png",
                fit: BoxFit.contain,
                width: 150,
                height: 30,
              )),
          body: BlocListener(
              bloc: logInBloc,
              listener: (context, state) {
                var data = state.model as UserResponse;
                if (state is Loading) showLoadingDialog(context);
                if (state is ErrorLoading) {
                  Navigator.of(context).pop();
                  errorDialog(
                    context: context,
                    text: data.msg,
                  );
                }
                if (state is Done) {
                  getUserLocation();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainPage(),
                      ),
                      (Route<dynamic> route) => false);
                }
              },
              child: Form(
                key: key,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  children: [
                    rowItem(Icons.mail,  translator.translate("email")),
                    CustomTextField(
                      hint: "example@gmail.com",
                      inputType: TextInputType.emailAddress,
                      validate: (String val) {
                        if (val.isEmpty) {
                          return " البريد الالكتروني غير صحيح";
                        }
                      },
                      value: (String val) {
                        logInBloc.updateEmail(val);
                      },
                    ),
                    rowItem(Icons.lock,  translator.translate("password")),
                    CustomTextField(
                      secureText: true,
                      validate: (String val) {
                        if (val.length < 8) {
                          return "الرقم السري غير صحيح";
                        }
                      },
                      value: (String val) {
                        logInBloc.updatePassword(val);
                      },
                      hint: "************",
                    ),
                    CustomButton(
                      onBtnPress: () {
                        if (!key.currentState.validate()) {
                          return;
                        } else {
                          logInBloc.add(Click());
                        }
                      },
                      text:  translator.translate("login"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgetPassword()));
                        },
                        child: Center(
                            child: Text( translator.translate("forget_password"))),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SignUp()));
                        },
                        child: Center(child: Text( translator.translate("no_acc")))),
                  ],
                ),
              ))),
    );
  }

  Widget rowItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 28,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              text,
              style: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  static Future<void> getUserLocation() async {
    final Location location = Location();
    String _error;
    try {
      await location.requestService();
      final LocationData _locationResult = await location.getLocation();
      final coordinates = new Coordinates(
          _locationResult.latitude, _locationResult.longitude);
      sharedPreferenceManager.writeData(CachingKey.USER_LAT, _locationResult.latitude);
      sharedPreferenceManager.writeData(CachingKey.USER_LONG, _locationResult.longitude);

    } catch (err) {
      _error = err.code;
    }
  }


}
