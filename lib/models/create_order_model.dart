import 'package:buty/helpers/network-mappers.dart';

class CreateOrderModel extends BaseMappable{
  bool status;
  String errNum;
  String msg;
  Order order;

  CreateOrderModel({this.status, this.errNum, this.msg, this.order});

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.order != null) {
      data['order'] = this.order.toJson();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    return CreateOrderModel(status: status,errNum: errNum,msg: msg,order: order);
  }
}

class Order {
  int id;
  String date;
  String time;
  int cost;
  int orderNum;
  int appCommission;
  String paymentStatus;
  String orderStatus;
  String duration;
  int beauticianId;
  int userId;
  int paymentMethodId;
  Null cardId;
  String locationType;
  String createdAt;

  Order(
      {this.id,
        this.date,
        this.time,
        this.cost,
        this.orderNum,
        this.appCommission,
        this.paymentStatus,
        this.orderStatus,
        this.duration,
        this.beauticianId,
        this.userId,
        this.paymentMethodId,
        this.cardId,
        this.locationType,
        this.createdAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    cost = json['cost'];
    orderNum = json['order_num'];
    appCommission = json['app_commission'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    duration = json['duration'];
    beauticianId = json['beautician_id'];
    userId = json['user_id'];
    paymentMethodId = json['payment_method_id'];
    cardId = json['card_id'];
    locationType = json['location_type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['time'] = this.time;
    data['cost'] = this.cost;
    data['order_num'] = this.orderNum;
    data['app_commission'] = this.appCommission;
    data['payment_status'] = this.paymentStatus;
    data['order_status'] = this.orderStatus;
    data['duration'] = this.duration;
    data['beautician_id'] = this.beauticianId;
    data['user_id'] = this.userId;
    data['payment_method_id'] = this.paymentMethodId;
    data['card_id'] = this.cardId;
    data['location_type'] = this.locationType;
    data['created_at'] = this.createdAt;
    return data;
  }
}