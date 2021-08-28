import 'package:buty/helpers/network-mappers.dart';

class CreditCardPaymentModel  extends BaseMappable{
  bool status;
  String errNum;
  String msg;
  Data data;

  CreditCardPaymentModel({this.status, this.errNum, this.msg, this.data});

  CreditCardPaymentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    return CreditCardPaymentModel(status: status,msg: msg,data: data,errNum: errNum);
  }
}

class Data {
  String orderId;
  int userId;
  String transactionId;
  String buildNumber;
  String ndc;
  String amount;
  String payTime;
  String updatedAt;
  String createdAt;
  int id;

  Data(
      {this.orderId,
        this.userId,
        this.transactionId,
        this.buildNumber,
        this.ndc,
        this.amount,
        this.payTime,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    userId = json['user_id'];
    transactionId = json['transaction_id'];
    buildNumber = json['buildNumber'];
    ndc = json['ndc'];
    amount = json['amount'];
    payTime = json['pay_time'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    data['transaction_id'] = this.transactionId;
    data['buildNumber'] = this.buildNumber;
    data['ndc'] = this.ndc;
    data['amount'] = this.amount;
    data['pay_time'] = this.payTime;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}