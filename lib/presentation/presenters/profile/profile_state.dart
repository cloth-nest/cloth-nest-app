// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ecommerce/domain/entities/user/user_entity.dart';
import 'package:flutter/material.dart';

class ProfileState {
  final bool isLoading;
  final bool isActive;
  final String? errorMessage;
  final File? selectedImageFile;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final String? firstName;
  final String? lastName;
  final String? navigateTo;
  final UserEntity? newUser;
  final String? phone;

  ProfileState({
    required this.isLoading,
    required this.isActive,
    this.errorMessage,
    this.selectedImageFile,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    this.firstName,
    this.lastName,
    this.navigateTo,
    this.newUser,
    this.phone,
  });

  factory ProfileState.initial() {
    return ProfileState(
      isLoading: false,
      isActive: false,
      firstNameController: TextEditingController(),
      lastNameController: TextEditingController(),
      phoneController: TextEditingController(),
    );
  }

  ProfileState copyWith({
    bool? isLoading,
    bool? isActive,
    String? errorMessage,
    File? selectedImageFile,
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? phoneController,
    String? firstName,
    String? lastName,
    String? navigateTo,
    UserEntity? newUser,
    String? phone,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isActive: isActive ?? this.isActive,
      errorMessage: errorMessage,
      selectedImageFile: selectedImageFile ?? this.selectedImageFile,
      firstNameController: firstNameController ?? this.firstNameController,
      lastNameController: lastNameController ?? this.lastNameController,
      phoneController: phoneController ?? this.phoneController,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      navigateTo: navigateTo,
      newUser: newUser ?? this.newUser,
      phone: phone ?? this.phone,
    );
  }
}
