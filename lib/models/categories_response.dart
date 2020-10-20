import 'package:buty/helpers/network-mappers.dart';

class CategoriesResponse extends BaseMappable {
  bool status;
  String errNum;
  String msg;
  List<Categories> categories;

  CategoriesResponse({this.status, this.errNum, this.msg, this.categories});

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    return CategoriesResponse(
        categories: categories, msg: msg, errNum: errNum, status: status);
  }
}

class Categories {
  int id;
  String nameAr;
  String icon;

  Categories({this.id, this.nameAr, this.icon});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['icon'] = this.icon;
    return data;
  }
}
