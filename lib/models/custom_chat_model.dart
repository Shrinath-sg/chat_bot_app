class CustomChatModel {
  int? userId;
  String? textId;
  String? text;
  String? time;
  bool? isValid = false;

  CustomChatModel(
      {this.userId, this.textId, this.text, this.time, this.isValid});
  CustomChatModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id']?.toInt();
    textId = json['text_id']?.toString();
    text = json['text']?.toString();
    time = json['time']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['text_id'] = textId;
    data['text'] = text;
    data['time'] = time;
    return data;
  }
}
