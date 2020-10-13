import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/Bolcs/loginBloc.dart';
import 'package:buty/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:buty/UI/CustomWidgets/ErrorDialog.dart';
import 'package:buty/UI/CustomWidgets/LoadingDialog.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
            },
            child: ListView(
              children: [
                CustomTextField(
                  hint: allTranslations.text("email"),
                ),
                CustomTextField(
                  hint: allTranslations.text("password"),
                ),
              ],
            )));
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
