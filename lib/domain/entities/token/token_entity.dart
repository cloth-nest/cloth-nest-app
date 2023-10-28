// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:ecommerce/data/models/token/token_model.dart';
import 'package:ecommerce/domain/entities/user/user_entity.dart';

class TokenEntity extends Equatable {
  final String accessToken;

  final String refreshToken;

  final UserEntity? user;

  final bool isRemember;

  const TokenEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    required this.isRemember,
  });

  @override
  List<Object> get props => [accessToken, refreshToken, isRemember];

  TokenModel toModel() {
    return TokenModel(
      accessToken: accessToken,
      refreshToken: refreshToken,
      userModel: user?.toModel(),
      isRemember: isRemember,
    );
  }

  TokenEntity copyWith({
    String? accessToken,
    String? refreshToken,
    UserEntity? user,
    bool? isRemember,
  }) {
    return TokenEntity(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
      isRemember: isRemember ?? this.isRemember,
    );
  }
}
