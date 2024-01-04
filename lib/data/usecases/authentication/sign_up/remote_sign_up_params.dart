import 'package:ecommerce/domain/usecases/authentication/sign_up/sign_up_params.dart';
import 'package:equatable/equatable.dart';

class RemoteSignUpParams extends Equatable {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String firebaseToken;

  const RemoteSignUpParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.firebaseToken,
  });

  @override
  List<Object?> get props => [email, password, firstName, lastName];

  factory RemoteSignUpParams.fromDomain(SignUpParams params) =>
      RemoteSignUpParams(
        email: params.email,
        password: params.password,
        firstName: params.firstName,
        lastName: params.lastName,
        firebaseToken: params.firebaseToken,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        "firstName": firstName,
        "lastName": lastName,
        "firebaseToken": firebaseToken,
      };
}
