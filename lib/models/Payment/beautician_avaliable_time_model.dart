import 'package:buty/helpers/network-mappers.dart';

class BeauticianAvaliableTimeModel extends BaseMappable {
  bool status;
  String errNum;
  String msg;
  List<String> data;

  BeauticianAvaliableTimeModel({this.status, this.errNum, this.msg, this.data});

  BeauticianAvaliableTimeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    data['data'] = this.data;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'].cast<String>();
    return BeauticianAvaliableTimeModel(status: status,msg: msg,errNum: errNum,data: data);
  }
}