import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/Base/NetworkUtil.dart';
import 'package:buty/helpers/shared_preference_manger.dart';
import 'package:buty/models/general_response.dart';
import 'package:buty/models/my_cards_response.dart';
import 'package:dio/dio.dart';

class CardsRepo {
  static Future<MyCardsResponse> GETALLCARDS() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    return NetworkUtil.internal().get(MyCardsResponse(),
        "users/cards/get-my-cards?lang=${allTranslations.currentLanguage}",
        headers: headers);
  }

  static Future<GeneralResponse> ADDNEWCARD(
      {String number, String date, String cvv, String holder_name}) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    print(number);
    print(holder_name);
    print(date);
    print(cvv);
    FormData data = FormData.fromMap({
      "number": number,
      "cvv": cvv,
      "holder_name": holder_name,
      "exp_date": date == null ? null : "02/23",
      "lang": allTranslations.currentLanguage
    });

    return NetworkUtil.internal().post(GeneralResponse(), "users/cards/store",
        headers: headers, body: data);
  }

  static Future<GeneralResponse> EditCard(
      {int id,String number, String date, String cvv, String holder_name}) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };

    print(number);
    print(holder_name);
    print(date);
    print(cvv);
    FormData data = FormData.fromMap({
      "card_id": id,
      "number": number,
      "cvv": cvv,
      "holder_name": holder_name,
      "exp_date": date == null ? null : "02/23",
      "lang": allTranslations.currentLanguage
    });

    return NetworkUtil.internal().post(GeneralResponse(), "users/cards/update",
        headers: headers, body: data);
  }
}
