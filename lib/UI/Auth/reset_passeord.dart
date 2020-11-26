import 'package:buty/Bolcs/reset_password_bloc.dart';
import 'package:buty/UI/Auth/login.dart';
import 'package:buty/UI/CustomWidgets/CustomBottomSheet.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:buty/UI/CustomWidgets/ErrorDialog.dart';
import 'package:buty/UI/CustomWidgets/LoadingDialog.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/general_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool seeNew = true;

  bool seeConfirm = true;

  void changeNew() {
    setState(() {
      seeNew = !seeNew;
    });
    print("Status ==> ${seeNew}");
  }

  void changeConfirm() {
    setState(() {
      seeConfirm = !seeConfirm;
    });
    print("Status ==> ${seeConfirm}");
  }

  GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Image.asset(
            "assets/images/header.png",
            fit: BoxFit.contain,
            width: 100,
            height: 30,
          )),
      body: BlocListener(
        bloc: resetPasswordBloc,
        listener: (context, state) {
          var data = state.model as GeneralResponse;
          if (state is Loading) showLoadingDialog(context);
          if (state is ErrorLoading) {
            Navigator.of(context).pop();
            errorDialog(
              context: context,
              text: data.msg,
            );
          }
          if (state is Done) {
            Navigator.pop(context);
            CustomSheet(
                context: context,
                widget: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        width: 100,
                        height: 10,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Icon(
                        Icons.check_circle,
                        size: 100,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Text(translator.translate("change_done")),
                    CustomButton(
                      text: translator.translate("login"),
                      onBtnPress: (){
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                                (Route<dynamic> route) => false);
                      },
                    ),
                  ],
                ));
          }
        },
        child: Form(
          key: key,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            children: [
              rowItem(Icons.lock, translator.translate("newPassword")),
              CustomTextField(
                value: (String val) {
                  resetPasswordBloc.updatePassword(val);
                  print(val);
                },
                validate: (String val) {
                  if (val.length < 8) {
                    return "الرجاء ادخال كلمة مرور صحيحة";
                  }
                },
                secureText: seeNew,
                hint: "**********",
              ),
              rowItem(Icons.lock, translator.translate("confirm_newPassword")),
              CustomTextField(
                validate: (String val) {
                  if (val.length < 8) {
                    return "الرجاء ادخال كلمة مرور صحيحة";
                  }
                },
                value: (String val) {
                  resetPasswordBloc.updateConfirmPassword(val);
                  print(val);

                },
                secureText: seeConfirm,
                hint: "**********",
              ),
              CustomButton(
                onBtnPress: () {
                  if (!key.currentState.validate()) {
                    return;
                  } else {
                    resetPasswordBloc.add(Click());
                  }
                },
                text: translator.translate("change"),
              )
            ],
          ),
        ),
      ),
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
            size: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              text,
              style: TextStyle(fontSize: 13),
            ),
          )
        ],
      ),
    );
  }
}
