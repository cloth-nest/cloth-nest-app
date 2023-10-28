import 'package:ecommerce/domain/usecases/authentication/reset_password/reset_password_params.dart';
import 'package:equatable/equatable.dart';

class RemoteResetPasswordParams extends Equatable {
  final String email;
  final String password;

  const RemoteResetPasswordParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];

  factory RemoteResetPasswordParams.fromDomain(ResetPasswordParams params) =>
      RemoteResetPasswordParams(
        email: params.email,
        password: params.password,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'newPassword': password,
      };
}
