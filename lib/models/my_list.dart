class MyList {
  int id;
  String nameAr;
  String nameEn;
  String price;
  String estimatedTime;
  int count;

  MyList({
    this.id,
    this.nameAr,
    this.nameEn,
    this.price,
    this.estimatedTime,
    this.count,
  });

  MyList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    price = json['price'];
    estimatedTime = json['estimated_time'];
    count = json["count"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['price'] = this.price;
    data['estimated_time'] = this.estimatedTime;
    data["count"]=this.count;
    return data;
  }
}
