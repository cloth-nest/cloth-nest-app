import 'package:ecommerce/domain/usecases/update_profile/update_profile_params.dart';
import 'package:equatable/equatable.dart';

class RemoteUpdateProfileParams extends Equatable {
  final String firstName;
  final String lastName;
  final String? avatar;

  const RemoteUpdateProfileParams({
    required this.firstName,
    required this.lastName,
    this.avatar,
  });

  @override
  List<Object?> get props => [firstName, lastName];

  factory RemoteUpdateProfileParams.fromDomain(UpdateProfileParams params) =>
      RemoteUpdateProfileParams(
        firstName: params.firstName,
        lastName: params.lastName,
        avatar: params.avatar,
      );

  Map<String, dynamic> toJson() {
    if (avatar != null) {
      return {
        'firstName': firstName,
        'lastName': lastName,
        'avatar': avatar,
      };
    }
    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
