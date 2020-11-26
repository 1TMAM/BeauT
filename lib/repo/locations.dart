import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:buty/Base/NetworkUtil.dart';
import 'package:buty/helpers/shared_preference_manger.dart';
import 'package:buty/models/general_response.dart';
import 'package:buty/models/my_address.dart';
import 'package:dio/dio.dart';

class AddressRepo {
  static Future<MyAddressResponse> GetAllAdress() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    return NetworkUtil.internal().get(MyAddressResponse(),
        "users/locations/get-my-locations?lang=${translator.currentLanguage}",
        headers: headers);
  }

  static Future<GeneralResponse> AddNewAddress(
      String address, double lat, double long) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    FormData data = FormData.fromMap({
      "lang": translator.currentLanguage,
      "address": address,
      "longitude": long,
      "latitude": lat
    });
    return NetworkUtil.internal().post(
        GeneralResponse(), "users/locations/store",
        headers: headers, body: data);
  }

  static Future<GeneralResponse> EditAddress(
      int id, String address, double lat, double long) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    FormData data = FormData.fromMap({
      "lang": translator.currentLanguage,
      "location_id": id,
      "address": address,
      "longitude": long,
      "latitude": lat
    });
    return NetworkUtil.internal().post(
        GeneralResponse(), "users/locations/update",
        headers: headers, body: data);
  }
}
