import 'package:bazi_app_frontend/models/bazichart_model.dart';

class UserModel {
  final String appDisplayName;
  final String email;
  final String imgUrl;
  final String birthDate;
  final String birthTime;
  final int gender;
  final BaziChart baziChart;

  UserModel({
    required this.appDisplayName,
    required this.email,
    required this.imgUrl,
    required this.birthDate,
    required this.birthTime,
    required this.gender,
    required this.baziChart,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      appDisplayName: json['appDisplayName'],
      email: json['email'],
      imgUrl: json['imgUrl'],
      birthDate: json['birthDate'],
      birthTime: json['birthTime'],
      gender: json['gender'],
      baziChart: BaziChart.fromJson(json['baziChart']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appDisplayName': appDisplayName,
      'email': email,
      'imgUrl': imgUrl,
      'birthDate': birthDate,
      'birthTime': birthTime,
      'gender': gender,
      'baziChart': baziChart.toJson(),
    };
  }
}
