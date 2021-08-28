import 'package:buty/helpers/network-mappers.dart';

class CategoriesResponse extends BaseMappable {
  bool status;
  String errNum;
  String msg;
  List<Categories> categories;

  CategoriesResponse({this.status, this.errNum, this.msg, this.categories});


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
  String nameEn;
  String icon;
  int beauticians_count;
  Categories({this.id, this.nameAr, this.icon,this.beauticians_count});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    icon = json['icon'];
    beauticians_count = json['beauticians_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['icon'] = this.icon;
    data['beauticians_count'] = this.beauticians_count;
    return data;
  }
}
