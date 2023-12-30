// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;
  final bool isRemember;
  final String firebaseToken;

  const LoginParams({
    required this.email,
    required this.password,
    this.isRemember = false,
    required this.firebaseToken,
  });

  @override
  List<Object?> get props => [
        email,
        password,
        isRemember,
        firebaseToken,
      ];
}
