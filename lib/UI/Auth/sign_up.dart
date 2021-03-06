import 'package:buty/Bolcs/signupBloc.dart';
import 'package:buty/UI/Auth/login.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:buty/UI/CustomWidgets/ErrorDialog.dart';
import 'package:buty/UI/CustomWidgets/LoadingDialog.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/general_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:url_launcher/url_launcher.dart';

import 'active_account.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool showVisa = false, acceptTerms = false;
  GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: translator.currentLanguage == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
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
          body: BlocListener<SignUpBloc, AppState>(
            bloc: signUpBloc,
            listener: (context, state) {
              var data = state.model as GeneralResponse;
              if (state is Loading) {
                showLoadingDialog(context);
              }
              if (state is ErrorLoading) {
                Navigator.of(context).pop();
                errorDialog(
                  context: context,
                  text: data.msg,
                );
                print("Dialoggg");
              }
              if (state is Done) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ActiveAccount(),
                    ),
                    (Route<dynamic> route) => false);
              }
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Form(
                key: key,
                child: Column(
                  children: [
                    rowItem(Icons.person, translator.translate("name")),
                    CustomTextField(
                      validate: (String val) {
                        if (val.isEmpty) {
                          return "${translator.translate("name_validator")}";
                        }
                      },
                      hint: translator.translate("write_name"),
                      value: (String val) {
                        signUpBloc.updateName(val);
                      },
                    ),
                    rowItem(Icons.phone, translator.translate("phone")),
                    CustomTextField(
                      validate: (String val) {
                        if (val.length < 10) {
                          return "${translator.translate("phone_validator")}";
                        }
                      },
                      hint: "966210025500",
                      inputType: TextInputType.phone,
                      value: (String val) {
                        signUpBloc.updateMobile(val);
                      },
                    ),
                    rowItem(Icons.mail, translator.translate("email")),
                    CustomTextField(
                      validate: (String val) {
                        if (val.isEmpty) {
                          return "${translator.translate("email_validator")}";
                        }
                      },
                      hint: "Example@gmail.com",
                      inputType: TextInputType.emailAddress,
                      value: (String val) {
                        signUpBloc.updateEmail(val);
                      },
                    ),
               /*     rowItem(Icons.location_on, translator.translate("address")),
                    CustomTextField(
                      validate: (String val) {
                        if (val.isEmpty) {
                          return "${translator.translate("address_validator")}";
                        }
                      },
                      hint: translator.translate("write_address"),
                      value: (String val) {
                        signUpBloc.updateAddress(val);
                      },
                    ),*/
                    rowItem(Icons.lock, translator.translate("password")),
                    CustomTextField(
                      validate: (String val) {
                        if (val.isEmpty) {
                          return "${translator.translate("password_validator")}";
                        }
                      },
                      hint: "************",
                      secureText: true,
                      value: (String val) {
                        signUpBloc.updatePassword(val);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          showVisa = !showVisa;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                translator.translate("add_depet_card"),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  translator.translate("default"),
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                              ),
                            ],
                          ),
                          showVisa == false
                              ? Icon(Icons.keyboard_arrow_up)
                              : Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
                    showVisa == false ? Visa() : SizedBox(),
                    SizedBox(
                      height: 20,
                    ),
                    checkBoxAndAccept(),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        if (!key.currentState.validate()) {
                          return;
                        } else {
                          if (acceptTerms) {
                            signUpBloc.add(Click());
                          } else {
                            errorDialog(
                                context: context,
                                text: translator
                                    .translate("Accept terms & conditions *"));
                          }
                        }
                      },
                      child: CustomButton(
                        text: translator.translate("register"),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Center(
                            child: Text(translator.translate("have_acc")))),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget Visa() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              translator.translate("card_number"),
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          CustomTextField(
            hint: translator.translate("card_number"),
            inputType: TextInputType.number,
            value: (String val) {
              signUpBloc.updateNumber(val);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              translator.translate("expireDate") ,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          CustomTextField(
            hint: "02/23",
            inputType: TextInputType.text,
            value: (String val) {
              signUpBloc.updateExpDate(val);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              translator.translate("card_holder"),
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          CustomTextField(
            hint: translator.translate("card_holder"),
            value: (String val) {
              signUpBloc.updateHolderName(val);
            },
          ),
        ],
      ),
    );
  }

  Widget rowItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: Row(
        children: [
          SizedBox(
            width: 2,
          ),
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget checkBoxAndAccept() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Theme(
              data: ThemeData(
                  unselectedWidgetColor: Colors.grey,
                  primaryColor: Colors.grey,
                  accentColor: Theme.of(context).primaryColor),
              child: Checkbox(
                  value: acceptTerms,
                  tristate: false,
                  onChanged: (bool value) {
                    setState(() {
                      acceptTerms = !acceptTerms;
                      print(acceptTerms);
                    });
                  })),
          Text(
            translator.translate("Accept terms & conditions *"),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: (){
              _launchURL(translator.currentLanguage == 'ar' ? 'https://beauty.wothoq.co/terms-user/ar' : 'https://beauty.wothoq.co/terms-user/en');
            },
            child: Text("  ${translator.translate("Click Here")}",style: TextStyle(color: Theme.of(context).primaryColor),),
          )
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
