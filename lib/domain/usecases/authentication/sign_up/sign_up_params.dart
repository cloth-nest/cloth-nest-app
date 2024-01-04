// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SignUpParams extends Equatable {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String firebaseToken;

  const SignUpParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.firebaseToken,
  });

  @override
  List<Object?> get props => [email, password, firstName, lastName];
}
