import 'package:equatable/equatable.dart';

class UpdateProfileParams extends Equatable {
  final String firstName;
  final String lastName;
  final String? avatar;

  const UpdateProfileParams({
    required this.lastName,
    required this.firstName,
    this.avatar,
  });

  @override
  List<Object?> get props => [firstName, lastName];
}
