

import 'package:buty/Base/NetworkUtil.dart';
import 'package:buty/helpers/shared_preference_manger.dart';
import 'package:buty/models/login_model.dart';

class UserDataRepo {
  static Future<UserResponse> getUserData() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
    await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    return NetworkUtil.internal().get(
        UserResponse(), "getClient",
        headers: headers);
  }
}
