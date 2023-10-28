import 'package:ecommerce/domain/usecases/authentication/forget_password/forget_password_params.dart';
import 'package:equatable/equatable.dart';

class RemoteForgetPasswordParams extends Equatable {
  final String email;

  const RemoteForgetPasswordParams({
    required this.email,
  });

  @override
  List<Object?> get props => [email];

  factory RemoteForgetPasswordParams.fromDomain(ForgetPasswordParams params) =>
      RemoteForgetPasswordParams(
        email: params.email,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
      };
}
