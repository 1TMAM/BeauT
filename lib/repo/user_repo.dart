import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/Base/NetworkUtil.dart';
import 'package:buty/helpers/shared_preference_manger.dart';
import 'package:buty/models/general_response.dart';
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
  static Future<GeneralResponse> ForgetPassword(String email) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    FormData data = FormData.fromMap({
      "email": email,
    });
    return NetworkUtil.internal().post(
      GeneralResponse(),
      "users/auth/resend-code",
      body: data,
    );
  }

  static Future<GeneralResponse> SIGNUP(
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
      "name": name,

      "email": email,
      "password": password,
      "mobile": mobile,
      "address": address,
      "longitude": 31.245175,
      "latitude":  41.245175,
      "number": number,
      "cvv": cvv,
      "exp_date":number==null ?null : "02/23",
      "holder_name": holder_name,
      "lang": allTranslations.currentLanguage
    });
    return NetworkUtil.internal().post(
      GeneralResponse(),
      "users/auth/signup",
      body: data,
    );
  }
}
