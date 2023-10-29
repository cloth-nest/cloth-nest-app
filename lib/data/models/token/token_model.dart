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
  final UserModel userModel;

  TokenModel({
    required this.accessToken,
    required this.refreshToken,
    required this.userModel,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'userModel': userModel.toJson(),
    };
  }

  factory TokenModel.fromMap(Map<String, dynamic> map) {
    print(map);
    return TokenModel(
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
      userModel: UserModel.fromJson(map['user']),
    );
  }

  TokenEntity toEntity() {
    return TokenEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
      user: userModel.toEntity(),
    );
  }
}
