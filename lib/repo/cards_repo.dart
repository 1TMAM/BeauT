import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/Base/NetworkUtil.dart';
import 'package:buty/helpers/shared_preference_manger.dart';
import 'package:buty/models/categories_response.dart';
import 'package:buty/models/my_cards_response.dart';

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
}
