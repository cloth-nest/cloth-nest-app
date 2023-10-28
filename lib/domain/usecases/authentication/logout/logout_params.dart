import 'package:equatable/equatable.dart';

class LogoutParams extends Equatable {
  final String refreshToken;

  const LogoutParams({
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [refreshToken];
}
