import 'package:buty/Base/shared_preference_manger.dart';
import 'package:buty/UI/CustomWidgets/ErrorDialog.dart';
import 'package:buty/UI/buty_details/payment_web_view.dart';
import 'package:buty/models/Payment/apple_payment_model.dart';
import 'package:buty/models/Payment/beautician_avaliable_time_model.dart';
import 'package:buty/models/Payment/credit_card_payment_model.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:buty/Base/NetworkUtil.dart';
import 'package:buty/models/AllPaymentMethodsResponse.dart';
import 'package:buty/models/general_response.dart';
import 'package:buty/models/user_credit_cards_model.dart';
import 'package:dio/dio.dart';

class PaymentRepo {

   Future<CreditCardPaymentModel> pay_with_credit_card(
      {int order_id, int card_id, String cvv, int amount}) async {
    var token =
    await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print(token);
    Map<String, String> headers = {
      'Authorization': token,
    };
    FormData data = FormData.fromMap({
      "order_id": order_id,
      "cvv": cvv,
      "card_id": card_id,
      "amount": amount
    });

    return NetworkUtil.internal().post(CreditCardPaymentModel(), "users/payments/pay",
        headers: headers, body: data);
  }


   Future<ApplePaymentModel> pay_with_apple_pay(
       {int order_id, int card_id, String verificationId, int amount}) async {
     var mSharedPreferenceManager = SharedPreferenceManager();
     var token =
     await mSharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
     print(token);
     Map<String, String> headers = {
       'Authorization': token,
     };
     FormData data = FormData.fromMap({
       "order_id": order_id,
       "verificationId": verificationId,
       "card_id": card_id,
       "amount": amount,
       "eci" : 07
     });

     return NetworkUtil.internal().post(ApplePaymentModel(), "users/payments/applePay",
         headers: headers, body: data);
   }



   Future<BeauticianAvaliableTimeModel> get_beautician_avaliable_time()async{
     var token = await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
     print("@@@ 111 @@@");
     Map<String, String> headers = {
       'Authorization': token,
     };
     print("@@@ 222 @@@");
     return NetworkUtil.internal().get(BeauticianAvaliableTimeModel(),
         "https://beauty.wothoq.co/api/users/orders/beautTimes?beautician_id=${await sharedPreferenceManager.readInteger(CachingKey.USER_ID)}&day_date=${await sharedPreferenceManager.readString(CachingKey.RESERVATION_DATE)}",
         headers: headers);
   }

    Future<void> hyperpay_payment({ int amount, int user_id, int order_id, BuildContext context}) async {
     print('1');
     String OnlinePayment_Url = 'users/payments/PayUrl';
     Dio dio = new Dio();
     var token = await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
     print(token);
     Map<String, String> headers = {
       'Authorization': token,
     };
     try {
       FormData _formData = FormData.fromMap({
         'amount': '${amount}',
         'user_id': '${user_id}',
         'order_id': '${order_id}',
       });
       print('2');
       final response = await dio.post('https://beauty.wothoq.co/api/users/payments/PayUrl', data: _formData,options: Options(headers: headers));
       ('response : ${response}');
       print('3');
       if (response.data['status']) {
         Navigator.pushReplacement(context, MaterialPageRoute(
             builder: (context)=> PaymentWebView(
               url: response.data['data'],
             )));
       /*  print('4');
         if (response.data['url_params']['Result'] == 'Successful' ||
             response.data['url_params']['Result'] == 'Success') {
           print('5');
           Navigator.push(
               context,
               MaterialPageRoute(
                   builder: (context) => PaymentResponse(
                     token: token,
                     status: 1,
                     user_id: user_id,
                     bill_cost: response.data['url_params']['amount'],
                     bill_number: response.data['url_params']['PaymentId'],
                     opertion_date: response.data['url_params']['invoice_date'],
                     salon_name: response.data['url_params']['salon_name'],
                     city: response.data['url_params']['salon_city'],
                   )));
           ('6');
         } else {
           print('7');
           Navigator.push(
               context,
               MaterialPageRoute(
                   builder: (context) => PaymentResponse(
                       token: token, status: 0, user_id: user_id)));
           print('8');
         }*/

       } else {
         errorDialog(context: context, text: response.data['msg']);
   /*      ('9');
         Navigator.push(
             context,
             MaterialPageRoute(
                 builder: (context) => PaymentResponse(
                     token: token, status: 0, user_id: user_id)));
         ('10');*/
       }
     } catch (e) {
       ('11');
       ('getPaymentResponse errorr');
       errorDialog(context: context, text: e.toString());
     }
   }

}
PaymentRepo paymentRepo = PaymentRepo();