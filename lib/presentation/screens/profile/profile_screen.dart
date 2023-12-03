import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/presentation/screens/account/account_presenter.dart';
import 'package:ecommerce/presentation/screens/profile/profile_presenter.dart';
import 'package:ecommerce/presentation/widgets/text_field/normal_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with WidgetsBindingObserver {
  late final ProfilePresenter _presenter;
  late final AccountPresenter _accountPresenter;

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _presenter = context.read<ProfilePresenter>();
    _presenter.addListener(_onListener);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _accountPresenter = context.read<AccountPresenter>();
      _presenter.initData(user: _accountPresenter.user);
    });
  }

  void _onListener() {
    if (_presenter.navigateTo != null) {
      _accountPresenter.setNewUser(_presenter.newUser);
      context.popBeamLocation();
    }
  }

  @override
  void dispose() {
    super.dispose();
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    phoneFocusNode.dispose();
    _presenter.removeListener(_onListener);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final accountPresenter = context.read<AccountPresenter>();
    const double heightInputField = 50.0;

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(
            icon: SvgPicture.asset(
              SvgPaths.iconArrowLeft,
            ),
            onPressed: () {
              if (context.canPopBeamLocation) {
                context.popBeamLocation();
              }
            },
          ),
        ),
        elevation: 0.3,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              'Edit Profile',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                _presenter.updateProfile();
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Selector<ProfilePresenter, bool>(
                  selector: (_, presenter) => presenter.isActive,
                  builder: (_, isActive, __) => Text(
                    'Save',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: isActive
                              ? AppColors.skyPerfectBlue
                              : AppColors.iconDisabled,
                        ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Selector<ProfilePresenter, File?>(
                          selector: (_, presenter) =>
                              presenter.selectedFileImage,
                          builder: (_, selectedFileImage, __) =>
                              selectedFileImage == null
                                  ? accountPresenter.user.avatar.isNotEmpty
                                      ? CircleAvatar(
                                          radius: 50,
                                          backgroundImage: NetworkImage(
                                              accountPresenter.user.avatar),
                                        )
                                      : Center(
                                          child: Image.asset(
                                            'assets/images/default_avatar.png',
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.contain,
                                          ),
                                        )
                                  : CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          FileImage(selectedFileImage),
                                    ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _presenter.pickImage();
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFF4F4F4),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Image.asset(SvgPaths.iconCamera),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: heightInputField,
                      child: Selector<ProfilePresenter, TextEditingController>(
                        selector: (_, presenter) =>
                            presenter.firstNameController,
                        builder: (_, firstNameController, __) =>
                            NormalTextField(
                          controller: firstNameController,
                          focusNode: firstNameFocusNode,
                          nextFocus: lastNameFocusNode,
                          placeHolder: 'Please enter your first name',
                          onChanged: (String? value) {
                            _presenter.setFirstName(firstName: value!);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: heightInputField,
                      child: Selector<ProfilePresenter, TextEditingController>(
                        selector: (_, presenter) =>
                            presenter.lastNameController,
                        builder: (_, lastNameController, __) => NormalTextField(
                          controller: lastNameController,
                          focusNode: lastNameFocusNode,
                          nextFocus: phoneFocusNode,
                          placeHolder: 'Please enter your last name',
                          onChanged: (String? value) {
                            _presenter.setLastName(lastName: value!);
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: heightInputField,
                      child: Selector<ProfilePresenter, TextEditingController>(
                        selector: (_, presenter) => presenter.phoneController,
                        builder: (_, phoneController, __) => NormalTextField(
                          controller: phoneController,
                          focusNode: phoneFocusNode,
                          placeHolder: 'Please enter your phone',
                          onChanged: (String? value) {
                            _presenter.setPhone(phone: value!);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Selector<ProfilePresenter, bool>(
            selector: (context, presenter) => presenter.isLoading,
            builder: (context, isLoading, _) {
              if (isLoading) {
                return Container(
                  color: Colors.grey.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
