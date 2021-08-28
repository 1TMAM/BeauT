
import 'package:buty/helpers/network-mappers.dart';

class CancelOrderReasonModel extends BaseMappable{
  bool status;
  String errNum;
  String msg;
  Data data;

  CancelOrderReasonModel({this.status, this.errNum, this.msg, this.data});

  CancelOrderReasonModel.fromJson(Map<String, dynamic> json) {
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

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    return CancelOrderReasonModel(status: status,msg: msg,errNum: errNum,data: data);
  }
}

class Data {
  String orderId;
  String cancelReason;
  String beauticianId;
  String details;
  int id;

  Data(
      {this.orderId,
        this.cancelReason,
        this.beauticianId,
        this.details,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    cancelReason = json['cancel_reason'];
    beauticianId = json['beautician_id'];
    details = json['details'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['cancel_reason'] = this.cancelReason;
    data['beautician_id'] = this.beauticianId;
    data['details'] = this.details;
    data['id'] = this.id;
    return data;
  }
}