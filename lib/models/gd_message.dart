import 'message.dart';

class GDMessage {
  GDMessage({
    required this.toId,
    required this.msg,
    required this.fromId,
    required this.sent,
    required this.username,
  });

  late final String toId;
  late final String msg;
  late final String fromId;
  late final String sent;
  late final String username;

  GDMessage.fromJson(Map<String, dynamic> json) {
    toId = json['toId'].toString();
    msg = json['msg'].toString();
    fromId = json['fromId'].toString();
    sent = json['sent'].toString();
    username = json['username'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['toId'] = toId;
    data['msg'] = msg;
    data['fromId'] = fromId;
    data['sent'] = sent;
    data['username'] = username;
    return data;
  }
}
