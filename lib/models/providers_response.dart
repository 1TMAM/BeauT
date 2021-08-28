/*class ProvidersResponse {
  bool status;
  String errNum;
  String msg;
  List<AllButicans> beauticians;

  ProvidersResponse({this.status, this.errNum, this.msg, this.beauticians});

  ProvidersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['beauticians'] != null) {
      beauticians = new List<AllButicans>();
      json['beauticians'].forEach((v) {
        beauticians.add(new AllButicans.fromJson(v));
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
}

class AllButicans {
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
  int reviews_count;
  City city;
  List<Services> services;
  List<Categories> categories;
  List<PaymentMethods> paymentMethods;
  TotalRate totalRate;
  List<Gallery> gallery;
  List<Schedule> schedule;

  AllButicans(
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
        this.reviews_count,
        // this.city,
        this.services,
        this.categories,
        this.paymentMethods,
        this.totalRate,
        this.gallery,
        this.schedule});

  AllButicans.fromJson(Map<String, dynamic> json) {
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
    reviews_count = json['reviews_count'];
    // city = json['city'] != null ? new City.fromJson(json['city']) : null;
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
    data['reviews_count'] = this.reviews_count;
    // if (this.city != null) {
    //   data['city'] = this.city.toJson();
    // }
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
        this.categoryId});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_ar'];
    detailsEn = json['details_ar'];
    detailsAr = json['details_ar'];
    icon = json['icon'];
    price = json['price'];
    estimatedTime = json['estimated_time'];
    bonus = json['bonus'];
    location = json['location'];
    beauticianId = json['beautician_id'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameAr;
    data['details_en'] = this.detailsAr;
    data['details_ar'] = this.detailsAr;
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
  String workFrom;
  String workTo;
  int beauticianId;
  String createdAt;
  Null deletedAt;

  Schedule(
      {this.id,
        this.dayName,
        this.dayDate,
        this.workFrom,
        this.workTo,
        this.beauticianId,
        this.createdAt,
        this.deletedAt});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dayName = json['day_name'];
    dayDate = json['day_date'];
    workFrom = json['work_from'];
    workTo = json['work_to'];
    beauticianId = json['beautician_id'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day_name'] = this.dayName;
    data['day_date'] = this.dayDate;
    data['work_from'] = this.workFrom;
    data['work_to'] = this.workTo;
    data['beautician_id'] = this.beauticianId;
    data['created_at'] = this.createdAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}*/


class ProvidersResponse {
  bool status;
  String errNum;
  String msg;
  List<AllButicans> beauticians;

  ProvidersResponse({this.status, this.errNum, this.msg, this.beauticians});

  ProvidersResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['beauticians'] != null) {
      beauticians = new List<AllButicans>();
      json['beauticians'].forEach((v) {
        beauticians.add(new AllButicans.fromJson(v));
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
}

class AllButicans {
  var id;
  var ownerName;
  var beautName;
  var email;
  var mobile;
  var instaLink;
  var cityId;
  var isActive;
  var isBlocked;
  var photo;
  var address;
  var longitude;
  var latitude;
  var appCommission;
  var status;
  var statusUpdatedAt;
  var visits;
  var distance;
  var reviewsCount;
  City city;
  List<Services> services;
  List<Categories> categories;
  List<PaymentMethods> paymentMethods;
  TotalRate totalRate;
  List<Gallery> gallery;
  List<Schedule> schedule;
  List<Rates> rates;

  AllButicans(
      {this.id,
        this.ownerName,
        this.beautName,
        this.email,
        this.mobile,
        this.instaLink,
        this.cityId,
        this.isActive,
        this.isBlocked,
        this.photo,
        this.address,
        this.longitude,
        this.latitude,
        this.appCommission,
        this.status,
        this.statusUpdatedAt,
        this.visits,
        this.distance,
        this.reviewsCount,
        this.city,
        this.services,
        this.categories,
        this.paymentMethods,
        this.totalRate,
        this.gallery,
        this.schedule,
        this.rates});

  AllButicans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerName = json['owner_name'];
    beautName = json['beaut_name'];
    email = json['email'];
    mobile = json['mobile'];
    instaLink = json['insta_link'];
    cityId = json['city_id'];
    isActive = json['is_active'];
    isBlocked = json['is_blocked'];
    photo = json['photo'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    appCommission = json['app_commission'];
    status = json['status'];
    statusUpdatedAt = json['status_updated_at'];
    visits = json['visits'];
    distance = json['distance'];
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
    data['insta_link'] = this.instaLink;
    data['city_id'] = this.cityId;
    data['is_active'] = this.isActive;
    data['is_blocked'] = this.isBlocked;
    data['photo'] = this.photo;
    data['address'] = this.address;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['app_commission'] = this.appCommission;
    data['status'] = this.status;
    data['status_updated_at'] = this.statusUpdatedAt;
    data['visits'] = this.visits;
    data['distance'] = this.distance;
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
  var id;
  var nameAr;
  var nameEn;
  var countryAr;
  var countryEn;

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
  var id;
  var nameAr;
  var nameEn;
  var detailsEn;
  var detailsAr;
  var icon;
  var price;
  var estimatedTime;
  var bonus;
  var location;
  var beauticianId;
  var categoryId;

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
        this.categoryId});

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
    return data;
  }
}

class Categories {
  var id;
  var nameAr;
  var nameEn;
  var icon;
  var beauticiansCount;
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
  var beauticianId;
  var categoryId;

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
  var id;
  var nameAr;
  var nameEn;

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
  var id;
  var value;
  var beauticianId;
  var createdAt;
  var updatedAt;

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
  var id;
  var photo;
  var beauticianId;

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
  var id;
  var dayId;
  var dayDate;
  var beauticianId;
  var status;
  var createdAt;
  var deletedAt;

  Schedule(
      {this.id,
        this.dayId,
        this.dayDate,
        this.beauticianId,
        this.status,
        this.createdAt,
        this.deletedAt});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dayId = json['day_id'];
    dayDate = json['day_date'];
    beauticianId = json['beautician_id'];
    status = json['status'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day_id'] = this.dayId;
    data['day_date'] = this.dayDate;
    data['beautician_id'] = this.beauticianId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}

class Rates {
  var id;
  var value;
  var comment;
  var orderNum;
  var beauticianId;
  var userId;
  var createdAt;

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