// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ResetPasswordParams extends Equatable {
  final String email;
  final String password;

  const ResetPasswordParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
