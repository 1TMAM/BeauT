import 'package:buty/models/updateProfileResponse.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:buty/Base/NetworkUtil.dart';
import 'package:buty/helpers/shared_preference_manger.dart';
import 'package:buty/models/NotificationResponse.dart';
import 'package:buty/models/general_response.dart';
import 'package:buty/models/login_model.dart';
import 'package:buty/models/user_profile_response.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataRepo {
  static Future<UserResponse> LOGIN(String email, String password) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
   // var token = await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    SharedPreferences preferences =await SharedPreferences.getInstance();

    print('device-token : ${preferences.getString("msgToken")}');
    print('email : $email');
    print('password : $password');
    FormData data = FormData.fromMap({
      "email": email,
      "password": password,
      "deviceToken" :preferences.getString("msgToken")==null?'device token' : preferences.getString("msgToken"),
    });
    return NetworkUtil.internal().post(
      UserResponse(),
      "users/auth/login",
      body: data,
    );
  }

//-------------------------------------------------------------------------------

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
      "users/auth/send-code",
      body: data,
    );
  }

//-------------------------------------------------------------------------------

  static Future<GeneralResponse> ResendCode(String email) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    FormData data = FormData.fromMap({
      "email": email,
    });
    return NetworkUtil.internal().post(
      GeneralResponse(),
      "users/auth/send-code",
      body: data,
    );
  }

//-------------------------------------------------------------------------------
  static Future<GeneralResponse>  CheckCode(String code) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var email = await mSharedPreferenceManager.readString(CachingKey.EMAIL);
    print(email);
    FormData data = FormData.fromMap({
      "email": email,
      "code": code,
      "lang": translator.currentLanguage
    });
    return NetworkUtil.internal().post(
      GeneralResponse(),
      "users/auth/code-check",
      body: data,
    );
  }

//-------------------------------------------------------------------------------
  static Future<GeneralResponse> ActiveAccountFunction(String code) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var email = await mSharedPreferenceManager.readString(CachingKey.EMAIL);
    print(email);
    FormData data = FormData.fromMap({
      "email": email,
      "code": code,
      "lang": translator.currentLanguage
    });
    return NetworkUtil.internal().post(
      GeneralResponse(),
      "users/auth/code-check",
      body: data,
    );
  }

//-------------------------------------------------------------------------------
  static Future<GeneralResponse> RestePassword(
      String password, String confirmPassword) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var email = await mSharedPreferenceManager.readString(CachingKey.EMAIL);
    print(email);
    FormData data = FormData.fromMap({
      "email": email,
      "password": password,
      "password_confirmation": confirmPassword,
      "lang": translator.currentLanguage
    });
    return NetworkUtil.internal().post(
      GeneralResponse(),
      "users/auth/reset-password",
      body: data,
    );
  }

//-------------------------------------------------------------------------------
  static Future<UpadteProfileResponse> UpdateProfileApi(
      String name,
      String email,
      String newPassword,
      String mobile,
      String currentPassword,
      String confirmPassword) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var email = await mSharedPreferenceManager.readString(CachingKey.EMAIL);
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };

    FormData data = FormData.fromMap({
      "update_name": name,
      "update_email": email,
      "update_mobile": mobile,
      "update_password": newPassword,
      "update_password_confirmation": confirmPassword,
      "current_password": currentPassword,
      "lang": translator.currentLanguage
    });
    return NetworkUtil.internal().post(UpadteProfileResponse(), "users/user/update",
        body: data, headers: headers);
  }

//-------------------------------------------------------------------------------
  static Future<UserProfileResoonse> GetProfileApi() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token = await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    Map<String, String> headers = {
      'Authorization': token,
    };
    return NetworkUtil.internal().post(UserProfileResoonse(), "users/user/get-user", headers: headers);
  }

//-------------------------------------------------------------------------------

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
    SharedPreferences preferences =await SharedPreferences.getInstance();
    print(token);
    FormData data = FormData.fromMap({
      "name": name,
      "email": email,
      "password": password,
      "mobile": mobile,
      "address": address,
      "longitude": 31.245175,
      "latitude": 41.245175,
      "number": number,
      "cvv": cvv,
      "exp_date": number == null ? null : "02/23",
      "holder_name": holder_name,
      "lang": translator.currentLanguage,
      "deviceToken" :preferences.getString("msgToken")==null?'device token' : preferences.getString("msgToken"),
    });
    return NetworkUtil.internal().post(
      GeneralResponse(),
      "users/auth/signup",
      body: data,
    );
  }

//-------------------------------------------------------------------------------
  static Future<NotificationResponse> GetNotifications() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    return NetworkUtil.internal().get(
        NotificationResponse(), "users/user/get-user-notifications?lang=${translator.currentLanguage}",
        headers: headers);
  }

  //-------------------------------------------------------------------------------

  static Future<GeneralResponse> ClearNotifications(int id) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    FormData data = FormData.fromMap({
      "id": id,
    });
    return NetworkUtil.internal().post(
        GeneralResponse(), "users/user/delete",
        headers: headers, body: data);
  }
}
