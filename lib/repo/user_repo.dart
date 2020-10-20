import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/Base/NetworkUtil.dart';
import 'package:buty/helpers/shared_preference_manger.dart';
import 'package:buty/models/login_model.dart';
import 'package:dio/dio.dart';

class UserDataRepo {
  static Future<UserResponse> LOGIN(String email, String password) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    FormData data = FormData.fromMap({
      "email": email,
      "password": password,
    });
    return NetworkUtil.internal().post(
      UserResponse(),
      "users/auth/login",
      body: data,
    );
  }

  static Future<UserResponse> SIGNUP(
      {String holder_name,
      String email,
      String name,
      String mobile,
      String password,
      String address,
      double lat,
      double lng,
      String number,
      String cvv,
      String exp_date}) async {

    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    FormData data = FormData.fromMap({
      "email": email,
      "name": name,
      "mobile": mobile,
      "address": address,
      "longitude": 23.88598885,
      "latitude":  45.07928888,
      "number": number,
      "cvv": cvv,
      "holder_name": holder_name,
      "exp_date":number==null ?null : "02/23",
      "password": password,
      "lang": allTranslations.currentLanguage
    });
    return NetworkUtil.internal().post(
      UserResponse(),
      "users/auth/signup",
      body: data,
    );
  }
}
