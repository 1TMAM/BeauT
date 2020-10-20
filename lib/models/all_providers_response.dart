import 'package:buty/helpers/network-mappers.dart';

class AllProvidersResponse extends BaseMappable {
  bool status;
  String errNum;
  String msg;
  List<Beauticians> beauticians;

  AllProvidersResponse({this.status, this.errNum, this.msg, this.beauticians});

  AllProvidersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['beauticians'] != null) {
      beauticians = new List<Beauticians>();
      json['beauticians'].forEach((v) {
        beauticians.add(new Beauticians.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.beauticians != null) {
      data['beauticians'] = this.beauticians.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['beauticians'] != null) {
      beauticians = new List<Beauticians>();
      json['beauticians'].forEach((v) {
        beauticians.add(new Beauticians.fromJson(v));
      });
    }
    return AllProvidersResponse(
        status: status, errNum: errNum, msg: msg, beauticians: beauticians);
  }
}

class Beauticians {
  int id;
  String ownerName;
  String beautName;
  String email;
  String mobile;
  String photo;
  String instaLink;
  String address;
  String longitude;
  String latitude;
  int appCommission;
  int status;
  String statusUpdatedAt;
  int cityId;
  int isActive;
  int isBlocked;
  City city;
  List<Services> services;
  List<Categories> categories;
  List<PaymentMethods> paymentMethods;

  Beauticians(
      {this.id,
      this.ownerName,
      this.beautName,
      this.email,
      this.mobile,
      this.photo,
      this.instaLink,
      this.address,
      this.longitude,
      this.latitude,
      this.appCommission,
      this.status,
      this.statusUpdatedAt,
      this.cityId,
      this.isActive,
      this.isBlocked,
      this.city,
      this.services,
      this.categories,
      this.paymentMethods});

  Beauticians.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerName = json['owner_name'];
    beautName = json['beaut_name'];
    email = json['email'];
    mobile = json['mobile'];
    photo = json['photo'];
    instaLink = json['insta_link'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    appCommission = json['app_commission'];
    status = json['status'];
    statusUpdatedAt = json['status_updated_at'];
    cityId = json['city_id'];
    isActive = json['is_active'];
    isBlocked = json['is_blocked'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    if (json['services'] != null) {
      services = new List<Services>();
      json['services'].forEach((v) {
        services.add(new Services.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    if (json['payment_methods'] != null) {
      paymentMethods = new List<PaymentMethods>();
      json['payment_methods'].forEach((v) {
        paymentMethods.add(new PaymentMethods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['owner_name'] = this.ownerName;
    data['beaut_name'] = this.beautName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['photo'] = this.photo;
    data['insta_link'] = this.instaLink;
    data['address'] = this.address;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['app_commission'] = this.appCommission;
    data['status'] = this.status;
    data['status_updated_at'] = this.statusUpdatedAt;
    data['city_id'] = this.cityId;
    data['is_active'] = this.isActive;
    data['is_blocked'] = this.isBlocked;
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    if (this.paymentMethods != null) {
      data['payment_methods'] =
          this.paymentMethods.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  int id;
  String nameAr;
  String countryAr;

  City({this.id, this.nameAr, this.countryAr});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    countryAr = json['country_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['country_ar'] = this.countryAr;
    return data;
  }
}

class Services {
  int beauticianId;
  String nameAr;
  String location;
  String detailsAr;
  String icon;
  String price;
  String estimatedTime;
  String bonus;

  Services(
      {this.beauticianId,
      this.nameAr,
      this.location,
      this.detailsAr,
      this.icon,
      this.price,
      this.estimatedTime,
      this.bonus});

  Services.fromJson(Map<String, dynamic> json) {
    beauticianId = json['beautician_id'];
    nameAr = json['name_ar'];
    location = json['location'];
    detailsAr = json['details_ar'];
    icon = json['icon'];
    price = json['price'];
    estimatedTime = json['estimated_time'];
    bonus = json['bonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['beautician_id'] = this.beauticianId;
    data['name_ar'] = this.nameAr;
    data['location'] = this.location;
    data['details_ar'] = this.detailsAr;
    data['icon'] = this.icon;
    data['price'] = this.price;
    data['estimated_time'] = this.estimatedTime;
    data['bonus'] = this.bonus;
    return data;
  }
}

class Categories {
  int id;
  String nameAr;
  String nameEn;
  String icon;
  Pivot pivot;

  Categories({this.id, this.nameAr, this.nameEn, this.icon, this.pivot});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    icon = json['icon'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['icon'] = this.icon;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  int beauticianId;
  int categoryId;

  Pivot({this.beauticianId, this.categoryId});

  Pivot.fromJson(Map<String, dynamic> json) {
    beauticianId = json['beautician_id'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['beautician_id'] = this.beauticianId;
    data['category_id'] = this.categoryId;
    return data;
  }
}

class PaymentMethods {
  int id;
  String nameAr;
  String nameEn;

  PaymentMethods({this.id, this.nameAr, this.nameEn});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    return data;
  }
}
