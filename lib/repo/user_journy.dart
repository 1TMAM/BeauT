import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:buty/Base/NetworkUtil.dart';
import 'package:buty/helpers/shared_preference_manger.dart';
import 'package:buty/models/all_providers_response.dart';
import 'package:buty/models/categories_response.dart';
import 'package:buty/models/current_ordera_model.dart';
import 'package:buty/models/general_response.dart';
import 'package:buty/models/search_by_category.dart';
import 'package:dio/dio.dart';

import '../models/BeauticianDetails.dart';

class UserJourny {

  static Future<CategoriesResponse> GETALLCATEGORIES() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    return NetworkUtil.internal().get(CategoriesResponse(), "user/categories/get-all-categories?lang=${translator.currentLanguage}", headers: headers);
  }

//------------------------------------------------------------------------------/

  static Future<AllProvidersResponse> GETALLPROVIDERS() async {
    print("provider 1");
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    print("provider 2");
    Map<String, String> headers = {
      'Authorization': token,
    };
    print("provider 3");
    return NetworkUtil.internal().get(
        AllProvidersResponse(), "user/provider/get-all-provider",
        headers: headers);
  }

  //------------------------------------------------------------------------------/

  static Future<CategoriesResponse> GetAllCategoriesAPI() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);

    Map<String, String> headers = {
      'Authorization': token,
    };
    return NetworkUtil.internal().get(CategoriesResponse(),
        "user/categories/get-all-categories?lang=${translator.currentLanguage}",
        headers: headers);
  }

//------------------------------------------------------------------------------/

  // static Future<SearchByCategoryResponse> SEARCHBYCATEGORY(int id) async {
  //   var mSharedPreferenceManager = SharedPreferenceManager();
  //   var token =
  //       await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
  //   print(token);
  //   Map<String, String> headers = {
  //     'Authorization': token,
  //   };
  //   return NetworkUtil.internal().get(SearchByCategoryResponse(),
  //       "users/search/category-search?category_id=${id}",
  //       headers: headers);
  // }

//------------------------------------------------------------------------------/

  static Future<BeauticianDetailsResponse> GetBeauticianDetails(int id) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    return NetworkUtil.internal().get(BeauticianDetailsResponse(),
        "user/provider/get-beautician?beautician_id=${id}",
        headers: headers);
  }

//------------------------------------------------------------------------------/

  // static Future<SearchByCategoryResponse> SEARCHBYTIME(String time) async {
  //   var mSharedPreferenceManager = SharedPreferenceManager();
  //   var token =
  //       await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
  //   print(token);
  //   Map<String, String> headers = {
  //     'Authorization': token,
  //   };
  //   return NetworkUtil.internal().get(SearchByCategoryResponse(),
  //       "users/search/search-beautician-time?time=${time}",
  //       headers: headers);
  // }
//------------------------------------------------------------------------------/

  // static Future<SearchByCategoryResponse> SearchByName(String Name) async {
  //   var mSharedPreferenceManager = SharedPreferenceManager();
  //   var token =
  //       await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
  //   print(token);
  //   Map<String, String> headers = {
  //     'Authorization': token,
  //   };
  //   return NetworkUtil.internal().get(SearchByCategoryResponse(),
  //       "users/search/search-beautician-name?name=${Name}",
  //       headers: headers);
  // }

//------------------------------------------------------------------------------/

  // static Future<SearchByCategoryResponse> SEARCHBYADDRESS(
  //     String address) async {
  //   var mSharedPreferenceManager = SharedPreferenceManager();
  //   var token =
  //       await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
  //   print(token);
  //   Map<String, String> headers = {
  //     'Authorization': token,
  //   };
  //   return NetworkUtil.internal().get(SearchByCategoryResponse(),
  //       "users/search/search-beautician-address?address=${address}",
  //       headers: headers);
  // }

//------------------------------------------------------------------------------/
  static Future<CurrentOrdersResponse> GETCURRENTORDERS() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    return NetworkUtil.internal().get(
        CurrentOrdersResponse(), "users/orders/get-current-orders",
        headers: headers);
  }

//------------------------------------------------------------------------------/
  static Future<GeneralResponse> CanselOrder(int id, int status) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    FormData data = FormData.fromMap({
      "order_id": id,
      "order_status": status,
    });
    Map<String, String> headers = {
      'Authorization': token,
    };
    return NetworkUtil.internal().post(GeneralResponse(), "users/orders/change-status",
        headers: headers, body: data);
  }

//------------------------------------------------------------------------------/
  static Future<GeneralResponse> CreateReservation(
      {String date,
      String time,
      int location_type,
      int beautician_id,
      List<int> services,
      List<int> person_num,
      int payment_method,
      String coupon,
      int location_id , int id }) async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    print("In RePPO");
    print("Sellected Date ===========>" + date);
    print("Location Time  ===========>${location_type == 0 ? "Home " : "AT  Butyy Place"}");
    print("beautician_id  ===========> ${beautician_id}");
    print("servces   ===========> ${services}");
    print("persons   ===========> ${person_num}");
    print("payment_method ======> ${payment_method} ");
    print("coupon ======>  ${coupon}");
    print("location_id  ======> ${location_id}");
    FormData data = FormData.fromMap({
      "lang": translator.currentLanguage,
      "date": date,
      "time": "10:00",
      "location_type": location_type,
      "beautician_id": beautician_id,
      "services": services,
      "person_num": person_num,
      "payment_method": payment_method,
      "coupon": coupon,
      "location_id": location_id,
    });

    Map<String, String> headers = {
      'Authorization': token,
    };
    return NetworkUtil.internal().post(GeneralResponse(), "users/orders/store",
        headers: headers, body: data);
  }

//------------------------------------------------------------------------------/
  static Future<CurrentOrdersResponse> GETDONEORDERS() async {
    var mSharedPreferenceManager = SharedPreferenceManager();
    var token =
        await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    return NetworkUtil.internal().get(
        CurrentOrdersResponse(), "users/orders/get-current-orders",
        headers: headers);
  }
//------------------------------------------------------------------------------/

}
