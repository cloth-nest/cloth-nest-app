import 'package:ecommerce/domain/entities/user/user_entity.dart';
import 'package:hive/hive.dart';
import 'package:ecommerce/data/models/constant.dart';

part 'user_model.g.dart';

@HiveType(typeId: kUserModelTypeId)
class UserModel extends HiveObject {
  @HiveField(0)
  final String mail;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String avatar;

  @HiveField(4)
  final String phoneNum;

  UserModel({
    required this.mail,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.phoneNum,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'mail': mail,
      'firstName': firstName,
      'lastName': lastName,
      'avatar': avatar,
      'phoneNum': phoneNum,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      mail: json['mail'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      avatar: json['avatar'] as String,
      phoneNum: json['phoneNum'] as String,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      mail: mail,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      phoneNum: phoneNum,
    );
  }
}
