import 'package:ecommerce/domain/entities/user/user_entity.dart';
import 'package:hive/hive.dart';
import 'package:ecommerce/data/models/constant.dart';

part 'user_model.g.dart';

@HiveType(typeId: kUserModelTypeId)
class UserModel extends HiveObject {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String avatar;

  @HiveField(4)
  final String phone;

  UserModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'avatar': avatar,
      'phone': phone,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json['email'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        avatar: json['avatar'] ?? '',
        phone: json['phone'] ?? '');
  }

  UserEntity toEntity() {
    return UserEntity(
      email: email,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      phone: phone,
    );
  }
}
