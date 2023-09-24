import 'package:ecommerce/data/models/user/user_model.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String mail;
  final String firstName;
  final String lastName;
  final String avatar;
  final String phoneNum;

  const UserEntity({
    required this.mail,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.phoneNum,
  });

  @override
  List<Object?> get props => [
        mail,
        firstName,
        lastName,
        avatar,
        phoneNum,
      ];

  UserModel toModel() {
    return UserModel(
      mail: mail,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      phoneNum: phoneNum,
    );
  }
}
