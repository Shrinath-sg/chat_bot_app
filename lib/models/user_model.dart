class UserModel {
  String? name;
  String? phone;
  String? email;
  String? password;

  UserModel({
    this.name,
    this.phone,
    this.email,
    this.password,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name']?.toString();
    phone = json['phone']?.toString();
    email = json['email']?.toString();
    password = json['password']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
