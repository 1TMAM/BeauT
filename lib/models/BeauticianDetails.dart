
import 'package:buty/helpers/network-mappers.dart';
/*

class BeauticianDetailsResponse extends BaseMappable {
  bool status;
  String errNum;
  String msg;
  List<Beautician> beautician;

  BeauticianDetailsResponse(
      {this.status, this.errNum, this.msg, this.beautician});

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['beautician'] != null) {
      beautician = new List<Beautician>();
      json['beautician'].forEach((v) {
        beautician.add(new Beautician.fromJson(v));
      });
    }
    return BeauticianDetailsResponse(
        status: status, errNum: errNum, msg: msg, beautician: beautician);
  }
}

class Beautician {
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
  int reviews_count;
  TotalRate totalRate;
  List<Gallery> gallery;
  List<Services> services;

  Beautician({this.id,
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
    this.reviews_count,
    this.totalRate,
    this.gallery,
    this.services});

  Beautician.fromJson(Map<String, dynamic> json) {
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
    reviews_count = json['reviews_count'];
    totalRate = json['total_rate'] != null
        ? new TotalRate.fromJson(json['total_rate'])
        : null;
    if (json['gallery'] != null) {
      gallery = new List<Gallery>();
      json['gallery'].forEach((v) {
        gallery.add(new Gallery.fromJson(v));
      });
    }
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
    data['reviews_count'] = this.reviews_count;
    if (this.totalRate != null) {
      data['total_rate'] = this.totalRate.toJson();
    }
    if (this.gallery != null) {
      data['gallery'] = this.gallery.map((v) => v.toJson()).toList();
    }
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TotalRate {
  int id;
  int value;
  int beauticianId;
  String createdAt;
  String updatedAt;

  TotalRate(
      {this.id, this.value, this.beauticianId, this.createdAt, this.updatedAt});

  TotalRate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    beauticianId = json['beautician_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['beautician_id'] = this.beauticianId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Gallery {
  int id;
  String photo;
  int beauticianId;

  Gallery({this.id, this.photo, this.beauticianId});

  Gallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    beauticianId = json['beautician_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.photo;
    data['beautician_id'] = this.beauticianId;
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
  int count;
  bool isSellected;


  Services({this.id,
    this.nameAr,
    this.nameEn,
    this.detailsEn,
    this.detailsAr,
    this.icon,
    this.price,
    this.estimatedTime,
    this.bonus,
    this.count,
    this.location,
    this.beauticianId,
    this.isSellected,
    this.categoryId});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_ar'];
    detailsEn = json['details_ar']==null ?'' : json['details_ar'];
    detailsAr = json['details_ar']==null ?'' : json['details_ar'];
    icon = json['icon'];
    price = json['price'];
    estimatedTime = json['estimated_time'];
    bonus = json['bonus'];
    location = json['location'];
    count=0;
    beauticianId = json['beautician_id'];
    categoryId = json['category_id'];
    isSellected=false ;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameAr;
    data['details_en'] = this.detailsAr ==null? '' : this.detailsAr;
    data['details_ar'] = this.detailsAr ==null? '' : this.detailsAr;
    data['icon'] = this.icon;
    data['price'] = this.price;
    data['estimated_time'] = this.estimatedTime;
    data['bonus'] = this.bonus;
    data['location'] = this.location;
    data['beautician_id'] = this.beauticianId;
    data['category_id'] = this.categoryId;
    return data;
  }
}
*/

class BeauticianDetailsResponse extends BaseMappable {
  bool status;
  String errNum;
  String msg;
  List<Beautician> beautician;

  BeauticianDetailsResponse({this.status, this.errNum, this.msg, this.beautician});

  BeauticianDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['beautician'] != null) {
      beautician = new List<Beautician>();
      json['beautician'].forEach((v) {
        beautician.add(new Beautician.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.beautician != null) {
      data['beautician'] = this.beautician.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['beautician'] != null) {
      beautician = new List<Beautician>();
      json['beautician'].forEach((v) {
        beautician.add(new Beautician.fromJson(v));
      });
    }
    return BeauticianDetailsResponse(status: status,msg: msg,errNum: errNum,beautician: beautician);
  }
}

class Beautician {
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
  int visits;
  int isBlocked;
  int reviewsCount;
  City city;
  List<Services> services;
  List<Categories> categories;
  List<PaymentMethods> paymentMethods;
  TotalRate totalRate;
  List<Gallery> gallery;
  List<Schedule> schedule;
  List<Rates> rates;

  Beautician(
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
        this.visits,
        this.isBlocked,
        this.reviewsCount,
        this.city,
        this.services,
        this.categories,
        this.paymentMethods,
        this.totalRate,
        this.gallery,
        this.schedule,
        this.rates});

  Beautician.fromJson(Map<String, dynamic> json) {
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
    visits = json['visits'];
    isBlocked = json['is_blocked'];
    reviewsCount = json['reviews_count'];
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
    totalRate = json['total_rate'] != null
        ? new TotalRate.fromJson(json['total_rate'])
        : null;
    if (json['gallery'] != null) {
      gallery = new List<Gallery>();
      json['gallery'].forEach((v) {
        gallery.add(new Gallery.fromJson(v));
      });
    }
    if (json['schedule'] != null) {
      schedule = new List<Schedule>();
      json['schedule'].forEach((v) {
        schedule.add(new Schedule.fromJson(v));
      });
    }
    if (json['rates'] != null) {
      rates = new List<Rates>();
      json['rates'].forEach((v) {
        rates.add(new Rates.fromJson(v));
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
    data['visits'] = this.visits;
    data['is_blocked'] = this.isBlocked;
    data['reviews_count'] = this.reviewsCount;
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
    if (this.totalRate != null) {
      data['total_rate'] = this.totalRate.toJson();
    }
    if (this.gallery != null) {
      data['gallery'] = this.gallery.map((v) => v.toJson()).toList();
    }
    if (this.schedule != null) {
      data['schedule'] = this.schedule.map((v) => v.toJson()).toList();
    }
    if (this.rates != null) {
      data['rates'] = this.rates.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  int id;
  String nameAr;
  String nameEn;
  String countryAr;
  String countryEn;

  City({this.id, this.nameAr, this.nameEn, this.countryAr, this.countryEn});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    countryAr = json['country_ar'];
    countryEn = json['country_en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['country_ar'] = this.countryAr;
    data['country_en'] = this.countryEn;
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
  int count;
  bool isSellected;


  Services({this.id,
    this.nameAr,
    this.nameEn,
    this.detailsEn,
    this.detailsAr,
    this.icon,
    this.price,
    this.estimatedTime,
    this.bonus,
    this.count,
    this.location,
    this.beauticianId,
    this.isSellected,
    this.categoryId});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_ar'];
    detailsEn = json['details_ar']==null ?'' : json['details_ar'];
    detailsAr = json['details_ar']==null ?'' : json['details_ar'];
    icon = json['icon'];
    price = json['price'];
    estimatedTime = json['estimated_time'];
    bonus = json['bonus'];
    location = json['location'];
    count=0;
    beauticianId = json['beautician_id'];
    categoryId = json['category_id'];
    isSellected=false ;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameAr;
    data['details_en'] = this.detailsAr ==null? '' : this.detailsAr;
    data['details_ar'] = this.detailsAr ==null? '' : this.detailsAr;
    data['icon'] = this.icon;
    data['price'] = this.price;
    data['estimated_time'] = this.estimatedTime;
    data['bonus'] = this.bonus;
    data['location'] = this.location;
    data['beautician_id'] = this.beauticianId;
    data['category_id'] = this.categoryId;
    return data;
  }
}
class Categories {
  int id;
  String nameAr;
  String nameEn;
  String icon;
  int beauticiansCount;
  Pivot pivot;
  List<Services> services;

  Categories(
      {this.id,
        this.nameAr,
        this.nameEn,
        this.icon,
        this.beauticiansCount,
        this.pivot,
        this.services});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    icon = json['icon'];
    beauticiansCount = json['beauticians_count'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
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
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['icon'] = this.icon;
    data['beauticians_count'] = this.beauticiansCount;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
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

class TotalRate {
  int id;
  int value;
  int beauticianId;
  String createdAt;
  String updatedAt;

  TotalRate(
      {this.id, this.value, this.beauticianId, this.createdAt, this.updatedAt});

  TotalRate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    beauticianId = json['beautician_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['beautician_id'] = this.beauticianId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Gallery {
  int id;
  String photo;
  int beauticianId;

  Gallery({this.id, this.photo, this.beauticianId});

  Gallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photo = json['photo'];
    beauticianId = json['beautician_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['photo'] = this.photo;
    data['beautician_id'] = this.beauticianId;
    return data;
  }
}

class Schedule {
  int id;
  String dayName;
  String dayDate;
  int beauticianId;
  String createdAt;
  Null deletedAt;

  Schedule(
      {this.id,
        this.dayName,
        this.dayDate,
        this.beauticianId,
        this.createdAt,
        this.deletedAt});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dayName = json['day_name'];
    dayDate = json['day_date'];
    beauticianId = json['beautician_id'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day_name'] = this.dayName;
    data['day_date'] = this.dayDate;
    data['beautician_id'] = this.beauticianId;
    data['created_at'] = this.createdAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Rates {
  int id;
  int value;
  String comment;
  int orderNum;
  int beauticianId;
  int userId;
  String createdAt;

  Rates(
      {this.id,
        this.value,
        this.comment,
        this.orderNum,
        this.beauticianId,
        this.userId,
        this.createdAt});

  Rates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    comment = json['comment'];
    orderNum = json['order_num'];
    beauticianId = json['beautician_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['comment'] = this.comment;
    data['order_num'] = this.orderNum;
    data['beautician_id'] = this.beauticianId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    return data;
  }
}