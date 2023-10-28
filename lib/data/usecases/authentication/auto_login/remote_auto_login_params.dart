import 'package:ecommerce/domain/usecases/authentication/auto_login/auto_login_params.dart';
import 'package:equatable/equatable.dart';

class RemoteAutoLoginParams extends Equatable {
  final String refreshToken;

  const RemoteAutoLoginParams({
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [refreshToken];

  factory RemoteAutoLoginParams.fromDomain(AutoLoginParams params) =>
      RemoteAutoLoginParams(
        refreshToken: params.refreshToken,
      );

  Map<String, dynamic> toJson() => {
        'refreshToken': refreshToken,
      };
}
