import 'package:buty/helpers/network-mappers.dart';

class CurrentOrdersResponse extends BaseMappable {
  bool status;
  String errNum;
  String msg;
  List<Orders> orders;

  CurrentOrdersResponse({this.status, this.errNum, this.msg, this.orders});

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['orders'] != null) {
      orders = new List<Orders>();
      json['orders'].forEach((v) {
        orders.add(new Orders.fromJson(v));
      });
    }
    return CurrentOrdersResponse(
        msg: msg, errNum: errNum, status: status, orders: orders);
  }
}

class Orders {
  int id;
  String date;
  String time;
  int cost;
  int orderNum;
  String orderStatus;
  int beauticianId;
  int userId;
  int paymentMethodId;
  Beautician beautician;
  List<Services> services;

  Orders(
      {this.id,
        this.date,
        this.time,
        this.cost,
        this.orderNum,
        this.orderStatus,
        this.beauticianId,
        this.userId,
        this.paymentMethodId,
        this.beautician,
        this.services});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    cost = json['cost'];
    orderNum = json['order_num'];
    orderStatus = json['order_status'];
    beauticianId = json['beautician_id'];
    userId = json['user_id'];
    paymentMethodId = json['payment_method_id'];
    beautician = json['beautician'] != null
        ? new Beautician.fromJson(json['beautician'])
        : null;
    if (json['services'] != null) {
      services = new List<Services>();
      json['services'].forEach((v) {
        services.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['time'] = this.time;
    data['cost'] = this.cost;
    data['order_num'] = this.orderNum;
    data['order_status'] = this.orderStatus;
    data['beautician_id'] = this.beauticianId;
    data['user_id'] = this.userId;
    data['payment_method_id'] = this.paymentMethodId;
    if (this.beautician != null) {
      data['beautician'] = this.beautician.toJson();
    }
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Beautician {
  int id;
  String beautName;

  Beautician({this.id, this.beautName});

  Beautician.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    beautName = json['beaut_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['beaut_name'] = this.beautName;
    return data;
  }
}

class Services {
  int id;
  String nameAr;
  String nameEn;
  String detailsEn;
  String detailsAr;
  String icon;
  String price;
  String estimatedTime;
  String bonus;
  String location;
  int beauticianId;
  int categoryId;
  Category category;

  Services(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.detailsEn,
        this.detailsAr,
        this.icon,
        this.price,
        this.estimatedTime,
        this.bonus,
        this.location,
        this.beauticianId,
        this.categoryId,
        this.category});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    detailsEn = json['details_en'];
    detailsAr = json['details_ar'];
    icon = json['icon'];
    price = json['price'];
    estimatedTime = json['estimated_time'];
    bonus = json['bonus'];
    location = json['location'];
    beauticianId = json['beautician_id'];
    categoryId = json['category_id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['details_en'] = this.detailsEn;
    data['details_ar'] = this.detailsAr;
    data['icon'] = this.icon;
    data['price'] = this.price;
    data['estimated_time'] = this.estimatedTime;
    data['bonus'] = this.bonus;
    data['location'] = this.location;
    data['beautician_id'] = this.beauticianId;
    data['category_id'] = this.categoryId;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }
}

class Category {
  int id;
  String nameEn;
  String icon;

  Category({this.id, this.nameEn, this.icon});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['icon'] = this.icon;
    return data;
  }
}