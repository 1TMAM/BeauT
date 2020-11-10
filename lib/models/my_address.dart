import 'package:buty/helpers/network-mappers.dart';

class MyAddressResponse extends BaseMappable {
  bool status;
  String errNum;
  String msg;
  List<Locations> locations;

  MyAddressResponse({this.status, this.errNum, this.msg, this.locations});

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['locations'] != null) {
      locations = new List<Locations>();
      json['locations'].forEach((v) {
        locations.add(new Locations.fromJson(v));
      });
    }
    return MyAddressResponse(
        status: status,
        locations: status == false ? null : locations,
        msg: msg,
        errNum: errNum);
  }
}

class Locations {
  int id;
  String address;
  String longitude;
  String latitude;
  int userId;
  String createdAt;
  bool isSellected;

  Locations(
      {this.id,
      this.address,
      this.longitude,
      this.latitude,
      this.userId,
      this.isSellected,
      this.createdAt});

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    isSellected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    return data;
  }
}
