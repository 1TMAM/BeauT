import 'package:buty/helpers/network-mappers.dart';

class MyCardsResponse extends BaseMappable {
  bool status;
  String errNum;
  String msg;
  List<Cards> cards;

  MyCardsResponse({this.status, this.errNum, this.msg, this.cards});

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['cards'] != null) {
      cards = new List<Cards>();
      json['cards'].forEach((v) {
        cards.add(new Cards.fromJson(v));
      });
    } else {
      cards = null;
    }
    return MyCardsResponse(
        status: status, errNum: errNum, msg: msg, cards: cards);
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
