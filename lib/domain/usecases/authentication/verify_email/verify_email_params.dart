// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class VerifyEmailParams extends Equatable {
  final String email;
  final String code;

  const VerifyEmailParams({
    required this.email,
    required this.code,
  });

  @override
  List<Object?> get props => [email, code];
}
