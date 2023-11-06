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

  UserModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'avatar': avatar,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      avatar: json['avatar'] ??
          'https://cloth-nest-1.s3.ap-southeast-1.amazonaws.com/DSC00611+(2).jpg',
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      email: email,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
    );
  }
}
