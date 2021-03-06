import 'package:buty/models/providers_response.dart';

class SearchResultResponse {
  bool status;
  String errNum;
  String msg;
  Data data;

  SearchResultResponse({this.status, this.errNum, this.msg, this.data});

  SearchResultResponse.fromJson(Map<String, dynamic> json) {
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
}

class Data {
  String categoryName;
  int countBeautician;
  List<AllButicans> beauticianServices;

  Data({this.categoryName, this.countBeautician, this.beauticianServices});

  Data.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    countBeautician = json['countBeautician'];
    if (json['beautician_services'] != null) {
      beauticianServices = new List<AllButicans>();
      json['beautician_services'].forEach((v) {
        beauticianServices.add(new AllButicans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['countBeautician'] = this.countBeautician;
    if (this.beauticianServices != null) {
      data['beautician_services'] =
          this.beauticianServices.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
//
// class BeauticianServices {
//   int id;
//   String ownerName;
//   String beautName;
//   String email;
//   String mobile;
//   String photo;
//   String instaLink;
//   String address;
//   String longitude;
//   String latitude;
//   int appCommission;
//   int status;
//   String statusUpdatedAt;
//   int cityId;
//   int isActive;
//   int visits;
//   int isBlocked;
//   TotalRate totalRate;
//   List<Gallery> gallery;
//   List<Services> services;
//
//   BeauticianServices(
//       {this.id,
//         this.ownerName,
//         this.beautName,
//         this.email,
//         this.mobile,
//         this.photo,
//         this.instaLink,
//         this.address,
//         this.longitude,
//         this.latitude,
//         this.appCommission,
//         this.status,
//         this.statusUpdatedAt,
//         this.cityId,
//         this.isActive,
//         this.visits,
//         this.isBlocked,
//         this.totalRate,
//         this.gallery,
//         this.services});
//
//   BeauticianServices.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     ownerName = json['owner_name'];
//     beautName = json['beaut_name'];
//     email = json['email'];
//     mobile = json['mobile'];
//     photo = json['photo'];
//     instaLink = json['insta_link'];
//     address = json['address'];
//     longitude = json['longitude'];
//     latitude = json['latitude'];
//     appCommission = json['app_commission'];
//     status = json['status'];
//     statusUpdatedAt = json['status_updated_at'];
//     cityId = json['city_id'];
//     isActive = json['is_active'];
//     visits = json['visits'];
//     isBlocked = json['is_blocked'];
//     totalRate = json['total_rate'] != null
//         ? new TotalRate.fromJson(json['total_rate'])
//         : null;
//     if (json['gallery'] != null) {
//       gallery = new List<Gallery>();
//       json['gallery'].forEach((v) {
//         gallery.add(new Gallery.fromJson(v));
//       });
//     }
//     if (json['services'] != null) {
//       services = new List<Services>();
//       json['services'].forEach((v) {
//         services.add(new Services.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['owner_name'] = this.ownerName;
//     data['beaut_name'] = this.beautName;
//     data['email'] = this.email;
//     data['mobile'] = this.mobile;
//     data['photo'] = this.photo;
//     data['insta_link'] = this.instaLink;
//     data['address'] = this.address;
//     data['longitude'] = this.longitude;
//     data['latitude'] = this.latitude;
//     data['app_commission'] = this.appCommission;
//     data['status'] = this.status;
//     data['status_updated_at'] = this.statusUpdatedAt;
//     data['city_id'] = this.cityId;
//     data['is_active'] = this.isActive;
//     data['visits'] = this.visits;
//     data['is_blocked'] = this.isBlocked;
//     if (this.totalRate != null) {
//       data['total_rate'] = this.totalRate.toJson();
//     }
//     if (this.gallery != null) {
//       data['gallery'] = this.gallery.map((v) => v.toJson()).toList();
//     }
//     if (this.services != null) {
//       data['services'] = this.services.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class TotalRate {
//   int id;
//   int value;
//   int beauticianId;
//   String createdAt;
//   String updatedAt;
//
//   TotalRate(
//       {this.id, this.value, this.beauticianId, this.createdAt, this.updatedAt});
//
//   TotalRate.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     value = json['value'];
//     beauticianId = json['beautician_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['value'] = this.value;
//     data['beautician_id'] = this.beauticianId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class Gallery {
//   int id;
//   String photo;
//   int beauticianId;
//
//   Gallery({this.id, this.photo, this.beauticianId});
//
//   Gallery.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     photo = json['photo'];
//     beauticianId = json['beautician_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['photo'] = this.photo;
//     data['beautician_id'] = this.beauticianId;
//     return data;
//   }
// }
//
// class Services {
//   int id;
//   String nameAr;
//   String nameEn;
//   String detailsEn;
//   String detailsAr;
//   String icon;
//   String price;
//   String estimatedTime;
//   String bonus;
//   String location;
//   int beauticianId;
//   int categoryId;
//
//   Services(
//       {this.id,
//         this.nameAr,
//         this.nameEn,
//         this.detailsEn,
//         this.detailsAr,
//         this.icon,
//         this.price,
//         this.estimatedTime,
//         this.bonus,
//         this.location,
//         this.beauticianId,
//         this.categoryId});
//
//   Services.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     nameAr = json['name_ar'];
//     nameEn = json['name_en'];
//     detailsEn = json['details_en'];
//     detailsAr = json['details_ar'];
//     icon = json['icon'];
//     price = json['price'];
//     estimatedTime = json['estimated_time'];
//     bonus = json['bonus'];
//     location = json['location'];
//     beauticianId = json['beautician_id'];
//     categoryId = json['category_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name_ar'] = this.nameAr;
//     data['name_en'] = this.nameEn;
//     data['details_en'] = this.detailsEn;
//     data['details_ar'] = this.detailsAr;
//     data['icon'] = this.icon;
//     data['price'] = this.price;
//     data['estimated_time'] = this.estimatedTime;
//     data['bonus'] = this.bonus;
//     data['location'] = this.location;
//     data['beautician_id'] = this.beauticianId;
//     data['category_id'] = this.categoryId;
//     return data;
//   }
// }
