// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/entities/token/token_entity.dart';
import 'package:hive/hive.dart';

import 'package:ecommerce/data/models/constant.dart';
import 'package:ecommerce/data/models/user/user_model.dart';

part 'token_model.g.dart';

@HiveType(typeId: kTokenModelTypeId)
class TokenModel extends HiveObject {
  @HiveField(0)
  final String accessToken;

  @HiveField(1)
  final String refreshToken;

  @HiveField(2)
  final UserModel? userModel;

  @HiveField(3)
  final bool isRemember;

  TokenModel({
    required this.accessToken,
    required this.refreshToken,
    this.userModel,
    required this.isRemember,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'userModel': userModel!.toJson(),
    };
  }

  factory TokenModel.fromMap(Map<String, dynamic> map) {
    return TokenModel(
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
      userModel: map['user'] != null ? UserModel.fromJson(map['user']) : null,
      isRemember: map['isRemember'] ?? false,
    );
  }

  TokenEntity toEntity() {
    return TokenEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
      user: userModel?.toEntity(),
      isRemember: isRemember,
    );
  }
}
