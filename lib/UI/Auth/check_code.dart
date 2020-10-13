import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/UI/Auth/reset_passeord.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class CheckCode extends StatefulWidget {
  final String email;

  const CheckCode({Key key, this.email}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CheckCodeState();
  }
}

class CheckCodeState extends State<CheckCode> {
  TextEditingController code;
  TextStyle style =
  TextStyle(color: Colors.black, fontFamily: 'Cairo', fontSize: 16);
  bool valid_code = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Image.asset(
            "assets/images/header.png",
            fit: BoxFit.cover,
            width: 100,
            height: 30,
          )),
      body: ListView(

        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(child: Text(allTranslations.text("enter_code"))),
          ),

          Container(
              width: double.infinity,
              height: 100,
              child: Center(
                child: PinCodeTextField(
                  pinBoxWidth: 60,
                  pinBoxHeight: 60,
                  pinBoxColor: Colors.white,
                  onDone: (String value) {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPassword()));
                  },
                  defaultBorderColor: Theme.of(context).primaryColor,
                  pinBoxRadius: 10,
                  highlightPinBoxColor: Colors.grey[50],
                  hasTextBorderColor: Theme.of(context).primaryColor,
                  controller: code,
                  pinTextStyle: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18),
                  textDirection: TextDirection.ltr,
                  keyboardType: TextInputType.phone,
                ),
              )),
        ],
      ),
    );
  }


}
