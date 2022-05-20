import 'package:task_app/models/custom_chat_model.dart';

class ConverstaionModel {
  String? chatId;
  String? chatTitle;
  String? time;
  List<CustomChatModel?>? chatList;

  ConverstaionModel({this.chatTitle, this.time, this.chatList, this.chatId});
  ConverstaionModel.fromJson(Map<String, dynamic> json) {
    chatTitle = json['chat_title']?.toString();
    time = json['time']?.toString();
    chatId = json['chat_id']?.toString();
    if (json['chat_list'] != null) {
      final v = json['chat_list'];
      final arr0 = <CustomChatModel>[];
      v.forEach((v) {
        arr0.add(CustomChatModel.fromJson(v));
      });
      chatList = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['chat_title'] = chatTitle;
    data['time'] = time;
    data['chat_id'] = chatId;
    if (chatList != null) {
      final v = chatList;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['chat_list'] = arr0;
    }
    return data;
  }
}
