import 'package:buty/helpers/network-mappers.dart';

class PaymentMethodsResponse extends BaseMappable {
  bool status;
  String errNum;
  String msg;
  List<PaymentMethods> paymentMethods;

  PaymentMethodsResponse(
      {this.status, this.errNum, this.msg, this.paymentMethods});

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['payment_methods'] != null) {
      paymentMethods = new List<PaymentMethods>();
      json['payment_methods'].forEach((v) {
        paymentMethods.add(new PaymentMethods.fromJson(v));
      });
    }

    return PaymentMethodsResponse(
        status: status, msg: msg, paymentMethods: paymentMethods);
  }
}

class PaymentMethods {
  int id;
  String nameAr;
  String nameEn;
  bool isSellected ;
  List<Cards> card;

  PaymentMethods({this.id, this.nameAr, this.nameEn, this.card ,this.isSellected});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    isSellected =false ;
    if (json['card'] != null) {
      card = new List<Cards>();
      json['card'].forEach((v) {
        card.add(new Cards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    if (this.card != null) {
      data['card'] = this.card.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cards {
  int id;
  String holderName;
  String expDate;
  int number;
  int cvv;
  String brand;
  String icon;
  int userId;
  int paymentMethodId;

  Cards(
      {this.id,
      this.holderName,
      this.expDate,
      this.number,
      this.cvv,
      this.brand,
      this.icon,
      this.userId,
      this.paymentMethodId});

  Cards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    holderName = json['holder_name'];
    expDate = json['exp_date'];
    number = json['number'];
    cvv = json['cvv'];
    brand = json['brand'];
    icon = json['icon'];
    userId = json['user_id'];
    paymentMethodId = json['payment_method_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['holder_name'] = this.holderName;
    data['exp_date'] = this.expDate;
    data['number'] = this.number;
    data['cvv'] = this.cvv;
    data['brand'] = this.brand;
    data['icon'] = this.icon;
    data['user_id'] = this.userId;
    data['payment_method_id'] = this.paymentMethodId;
    return data;
  }
}
