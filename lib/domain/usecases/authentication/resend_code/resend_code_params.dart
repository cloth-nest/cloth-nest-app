// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ResendCodeParams extends Equatable {
  final String email;

  const ResendCodeParams({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}
