import 'package:ecommerce/domain/usecases/authentication/resend_code/resend_code_params.dart';
import 'package:equatable/equatable.dart';

class RemoteResendCodeParams extends Equatable {
  final String email;

  const RemoteResendCodeParams({
    required this.email,
  });

  @override
  List<Object?> get props => [email];

  factory RemoteResendCodeParams.fromDomain(ResendCodeParams params) =>
      RemoteResendCodeParams(
        email: params.email,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
      };
}
