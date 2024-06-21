class LoginModel {
  String? token;
  User? user;
  LoginModel({this.token, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = (json['token'] != null ? User.fromJson(json['token']) : null) as String?;
    user = json['user'] != null ? User.fromJson(json['user']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? firstName;
  String? lastName;
  String? email;
  String? image;
  String? phoneNumber;

  User(
      {this.firstName,
      this.lastName,
      this.email,
      this.image,
      this.phoneNumber});

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    image = json['image'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['image'] = image;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
