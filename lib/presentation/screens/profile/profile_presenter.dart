import 'dart:io';

import 'package:ecommerce/domain/entities/user/user_entity.dart';
import 'package:flutter/material.dart';

abstract class ProfilePresenter implements ChangeNotifier {
  bool get isLoading;
  bool get isActive;
  String? get errorMessage;
  File? get selectedFileImage;
  TextEditingController get firstNameController;
  TextEditingController get lastNameController;
  TextEditingController get phoneController;
  String? get navigateTo;
  UserEntity? get newUser;

  void pickImage();
  void setFirstName({required String firstName});
  void setLastName({required String lastName});
  void setPhone({required String phone});
  void initData({required UserEntity user});
  void updateProfile();
}
