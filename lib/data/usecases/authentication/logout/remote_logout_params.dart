import 'package:ecommerce/domain/usecases/authentication/logout/logout_params.dart';
import 'package:equatable/equatable.dart';

class RemoteLogoutParams extends Equatable {
  final String refreshToken;

  const RemoteLogoutParams({
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [refreshToken];

  factory RemoteLogoutParams.fromDomain(LogoutParams params) =>
      RemoteLogoutParams(
        refreshToken: params.refreshToken,
      );

  Map<String, dynamic> toJson() => {
        'refreshToken': refreshToken,
      };
}
