import 'dart:io';

import 'package:ecommerce/domain/entities/user/user_entity.dart';
import 'package:ecommerce/domain/usecases/update_profile/fetch_update_profile.dart';
import 'package:ecommerce/domain/usecases/update_profile/update_profile_params.dart';
import 'package:ecommerce/domain/usecases/upload_avatar/fetch_upload_avatar.dart';
import 'package:ecommerce/presentation/presenters/profile/profile_state.dart';
import 'package:ecommerce/presentation/screens/profile/profile_presenter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ProviderProfilePresenter with ChangeNotifier implements ProfilePresenter {
  ProfileState _state;

  final FetchUploadAvatar _fetchUploadAvatar;
  final FetchUpdateProfile _fetchUpdateProfile;

  ProviderProfilePresenter({
    required ProfileState state,
    required FetchUpdateProfile fetchUpdateProfile,
    required FetchUploadAvatar fetchUploadAvatar,
  })  : _state = state,
        _fetchUpdateProfile = fetchUpdateProfile,
        _fetchUploadAvatar = fetchUploadAvatar;

  @override
  String? get errorMessage => _state.errorMessage;

  @override
  bool get isActive => _state.isActive;

  @override
  bool get isLoading => _state.isLoading;

  @override
  File? get selectedFileImage => _state.selectedImageFile;

  @override
  void pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      List<File> files = [];

      if (result != null) {
        for (var path in result.paths) {
          File file = File(path!);
          files.add(file);
        }
        _state = _state.copyWith(
          selectedImageFile: files[0],
          isActive: true,
        );
        notifyListeners();
      } else {
        // User canceled the picker
      }
    } catch (e) {
      _state = _state.copyWith(errorMessage: e.toString());
      notifyListeners();
    }
  }

  @override
  TextEditingController get firstNameController => _state.firstNameController;

  @override
  TextEditingController get lastNameController => _state.lastNameController;

  @override
  TextEditingController get phoneController => _state.phoneController;

  @override
  void setFirstName({required String firstName}) {
    _state = _state.copyWith(
      firstName: firstName,
      isActive: true,
    );
    notifyListeners();
  }

  @override
  void setLastName({required String lastName}) {
    _state = _state.copyWith(
      lastName: lastName,
      isActive: true,
    );
    notifyListeners();
  }

  @override
  void setPhone({required String phone}) {
    _state = _state.copyWith(
      phone: phone,
      isActive: true,
    );
    notifyListeners();
  }

  @override
  void initData({required UserEntity user}) {
    _state = _state.copyWith(
      firstName: user.firstName,
      lastName: user.lastName,
      firstNameController: TextEditingController(text: user.firstName),
      lastNameController: TextEditingController(text: user.lastName),
      phoneController: TextEditingController(text: user.phone),
    );
    notifyListeners();
  }

  @override
  void updateProfile() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    try {
      String? avatar;
      if (selectedFileImage != null) {
        avatar = await _fetchUploadAvatar(file: selectedFileImage!);
      }
      await _fetchUpdateProfile.call(
        params: UpdateProfileParams(
          lastName: _state.lastName!,
          firstName: _state.firstName!,
          avatar: avatar,
        ),
      );
      _state = _state.copyWith(
        isLoading: false,
        navigateTo: 'account',
        newUser: UserEntity(
          email: '',
          firstName: _state.firstName!,
          lastName: _state.lastName!,
          avatar: avatar ?? '',
          phone: _state.phone ?? '',
        ),
      );
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(isLoading: false, errorMessage: e.toString());
      notifyListeners();
    }
  }

  @override
  String? get navigateTo => _state.navigateTo;

  @override
  UserEntity? get newUser => _state.newUser;
}
