import 'package:ecommerce/domain/usecases/authentication/verify_email/verify_email_params.dart';
import 'package:equatable/equatable.dart';

class RemoteVerifyEmailParams extends Equatable {
  final String email;
  final String code;

  const RemoteVerifyEmailParams({
    required this.email,
    required this.code,
  });

  @override
  List<Object?> get props => [email, code];

  factory RemoteVerifyEmailParams.fromDomain(VerifyEmailParams params) =>
      RemoteVerifyEmailParams(
        email: params.email,
        code: params.code,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'code': int.tryParse(code),
      };
}
