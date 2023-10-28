import 'package:equatable/equatable.dart';

class AutoLoginParams extends Equatable {
  final String refreshToken;

  const AutoLoginParams({
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [refreshToken];
}
