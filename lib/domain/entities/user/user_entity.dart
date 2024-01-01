import 'package:ecommerce/data/models/user/user_model.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;
  final String phone;

  const UserEntity(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.avatar,
      required this.phone});

  factory UserEntity.inital() {
    return const UserEntity(
      email: '',
      firstName: '',
      lastName: '',
      avatar: '',
      phone: '',
    );
  }

  @override
  List<Object?> get props => [
        email,
        firstName,
        lastName,
        avatar,
      ];

  UserModel toModel() {
    return UserModel(
      email: email,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      phone: phone,
    );
  }
}
