// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ForgetPasswordParams extends Equatable {
  final String email;

  const ForgetPasswordParams({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}
