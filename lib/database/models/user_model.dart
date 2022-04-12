

import 'dart:convert';
import 'dart:ffi';

UserModel userFromJson(String str) => UserModel.toObject(json.decode(str));
class UserModel {
  String token;

  UserModel({required this.token});

  factory UserModel.toObject(Map<String,dynamic> json) =>
      UserModel(token: json['token'],
      );

  Map<String,dynamic> toJson() => {
    "token" : token,
  };
}

class User {
  late String id;
  late String name;
  late String email;
  late String phone;
  late String dateofBirth;
  late int gender;
  late String password;

  User({required this.id, required this.name, required this.email, required this.phone, required this.dateofBirth,
      required this.gender, required this.password});

  factory User.toObject(Map<String,dynamic> json) =>
      User(id: json['_id'],
          name:json['name'],
          email:json['email'],
          phone:json['phone'],
          dateofBirth:json['dateofBirth'],
          gender:json['gender'],
          password:json['userPwd']
      );

  Map<String,dynamic> toJon() => {
    "_id" : id,
    "name" : name,
    "email" : email,
    "phone" : phone,
    "dateofBirth" : dateofBirth,
    "gender" : gender,
    "userPwd" : password
  };

}