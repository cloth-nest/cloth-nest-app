// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/data/models/token/token_model.dart';
import 'package:equatable/equatable.dart';

import 'package:ecommerce/domain/entities/user/user_entity.dart';

class TokenEntity extends Equatable {
  final String accessToken;

  final String refreshToken;

  final UserEntity? user;

  const TokenEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  @override
  List<Object> get props => [accessToken, refreshToken];

  TokenModel toModel() {
    return TokenModel(
      accessToken: accessToken,
      refreshToken: refreshToken,
      userModel: user?.toModel(),
    );
  }
}
