class ChatModelRestaurant {
  String? bot;
  String? human;
  bool? isMe = false;

  ChatModelRestaurant({this.bot, this.human, this.isMe = false});
  ChatModelRestaurant.fromJson(Map<String, dynamic> json) {
    bot = json['bot']?.toString();
    human = json['human']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bot'] = bot;
    data['human'] = human;
    return data;
  }
}

class ChatModel {
  List<ChatModelRestaurant?>? restaurant;

  ChatModel({
    this.restaurant,
  });
  ChatModel.fromJson(Map<String, dynamic> json) {
    if (json['restaurant'] != null) {
      final v = json['restaurant'];
      final arr0 = <ChatModelRestaurant>[];
      v.forEach((v) {
        arr0.add(ChatModelRestaurant.fromJson(v));
      });
      restaurant = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (restaurant != null) {
      final v = restaurant;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['restaurant'] = arr0;
    }
    return data;
  }
}
