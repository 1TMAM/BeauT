import 'package:buty/helpers/network-mappers.dart';

class NotificationResponse extends BaseMappable {
  bool status;
  String errNum;
  String msg;
  List<Notifications> notifications;

  NotificationResponse(
      {this.status, this.errNum, this.msg, this.notifications});

  @override
  Mappable fromJson(Map<String,dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['notifications'] != null) {
      notifications = new List<Notifications>();
      json['notifications'].forEach((v) {
        notifications.add(new Notifications.fromJson(v));
      });
    }
    return NotificationResponse(msg: msg , status: status ,errNum: errNum ,notifications: notifications);
  }
}

class Notifications {
  int id;
  String title;
  String message;
  int senderBeauticianId;
  String createdAt;
  String time;
  Beautician beautician;

  Notifications(
      {this.id,
        this.title,
        this.message,
        this.senderBeauticianId,
        this.createdAt,
        this.time,
        this.beautician});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    senderBeauticianId = json['sender_beautician_id'];
    createdAt = json['created_at'];
    time = json['time'];
    beautician = json['beautician'] != null
        ? new Beautician.fromJson(json['beautician'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['sender_beautician_id'] = this.senderBeauticianId;
    data['created_at'] = this.createdAt;
    data['time'] = this.time;
    if (this.beautician != null) {
      data['beautician'] = this.beautician.toJson();
    }
    return data;
  }
}

class Beautician {
  int id;
  String beautName;

  Beautician({this.id, this.beautName});

  Beautician.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    beautName = json['beaut_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['beaut_name'] = this.beautName;
    return data;
  }
}
