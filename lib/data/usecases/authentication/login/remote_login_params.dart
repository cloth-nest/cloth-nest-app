import 'package:ecommerce/domain/usecases/authentication/login/login_params.dart';
import 'package:equatable/equatable.dart';

class RemoteLoginParams extends Equatable {
  final String email;
  final String password;
  final bool isRemember;

  const RemoteLoginParams({
    required this.email,
    required this.password,
    required this.isRemember,
  });

  @override
  List<Object?> get props => [email, password, isRemember];

  factory RemoteLoginParams.fromDomain(LoginParams params) => RemoteLoginParams(
        email: params.email,
        password: params.password,
        isRemember: params.isRemember,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
