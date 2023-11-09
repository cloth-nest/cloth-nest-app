import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/app/resources/app_themes.dart';
import 'package:ecommerce/domain/entities/place/place_entity.dart';
import 'package:ecommerce/presentation/screens/add_address/widgets/w_combo_box.dart';
import 'package:ecommerce/presentation/screens/detail_address/detail_address_presenter.dart';
import 'package:ecommerce/presentation/widgets/button/b_round_button.dart';
import 'package:ecommerce/presentation/widgets/text_field/normal_text_field.dart';
import 'package:ecommerce/presentation/widgets/w_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DetailAddressScreen extends StatefulWidget {
  final int idAddress;

  const DetailAddressScreen({
    super.key,
    required this.idAddress,
  });

  @override
  State<DetailAddressScreen> createState() => _DetailAddressScreenState();
}

class _DetailAddressScreenState extends State<DetailAddressScreen> {
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode mailFocusNode = FocusNode();

  late DetailAddressPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = context.read<DetailAddressPresenter>();
    _presenter.addListener(_onListener);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _presenter.initData(idAddress: widget.idAddress);
    });
  }

  void _onListener() {
    if (_presenter.navigateTo != null) {
      if (context.canPopBeamLocation) {
        context.popBeamLocation();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _presenter.removeListener(_onListener);

    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    phoneFocusNode.dispose();
    mailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final double horizontalPaddingSubmitButton = size.width * (75 / 390);
    const double heightInputField = 50.0;

    return Scaffold(
      appBar: const WAppBar(title: 'Detail Address'),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    height: heightInputField,
                    child:
                        Selector<DetailAddressPresenter, TextEditingController>(
                      selector: (_, presenter) => presenter.emailController,
                      builder: (_, mailController, __) => NormalTextField(
                        controller: mailController,
                        focusNode: mailFocusNode,
                        nextFocus: firstNameFocusNode,
                        placeHolder: 'Please enter your email',
                        onChanged: (String? value) {
                          _presenter.setEmail(newEmail: value!);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: heightInputField,
                    child:
                        Selector<DetailAddressPresenter, TextEditingController>(
                      selector: (_, presenter) => presenter.firstNameController,
                      builder: (_, firstNameController, __) => NormalTextField(
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
                  const SizedBox(height: 16),
                  SizedBox(
                    height: heightInputField,
                    child:
                        Selector<DetailAddressPresenter, TextEditingController>(
                      selector: (_, presenter) => presenter.lastNameController,
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
                  const SizedBox(height: 16),
                  SizedBox(
                    height: heightInputField,
                    child:
                        Selector<DetailAddressPresenter, TextEditingController>(
                      selector: (_, presenter) => presenter.phoneController,
                      builder: (_, phoneController, __) => NormalTextField(
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        focusNode: phoneFocusNode,
                        // nextFocus: lastNameFocusNode,
                        placeHolder: 'Please enter your phone',
                        onChanged: (String? value) {
                          _presenter.setPhone(phone: value!);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: heightInputField,
                    child: Selector<DetailAddressPresenter, List<PlaceEntity>>(
                        selector: (_, presenter) => presenter.provinces,
                        builder: (_, provinces, __) {
                          return Selector<DetailAddressPresenter, PlaceEntity?>(
                              selector: (_, presenter) =>
                                  presenter.selectedProvince,
                              builder: (_, selectedProvince, __) {
                                return WComboBox(
                                  callback: (newProvince) {
                                    _presenter.setProvince(
                                        newProvince: newProvince);
                                  },
                                  source: provinces,
                                  value: selectedProvince,
                                );
                              });
                        }),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: heightInputField,
                    child: Selector<DetailAddressPresenter, List<PlaceEntity>>(
                        selector: (_, presenter) => presenter.districts,
                        builder: (_, districts, __) {
                          return Selector<DetailAddressPresenter, PlaceEntity?>(
                            selector: (_, presenter) =>
                                presenter.selectedDistrict,
                            builder: (_, selectedDistrict, __) {
                              return WComboBox(
                                callback: (newDistrict) {
                                  _presenter.setDistrict(
                                      newDistrict: newDistrict);
                                },
                                source: districts,
                                value: selectedDistrict,
                              );
                            },
                          );
                        }),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: heightInputField,
                    child: Selector<DetailAddressPresenter, List<PlaceEntity>>(
                      selector: (_, presenter) => presenter.wards,
                      builder: (_, wards, __) =>
                          Selector<DetailAddressPresenter, PlaceEntity?>(
                        selector: (_, presenter) => presenter.selectedWard,
                        builder: (_, selectedWard, __) => WComboBox(
                          callback: (newWard) {
                            _presenter.setWard(newWard: newWard);
                          },
                          source: wards,
                          value: selectedWard,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: heightInputField,
                    child:
                        Selector<DetailAddressPresenter, TextEditingController>(
                      selector: (_, presenter) => presenter.detailController,
                      builder: (_, detailController, __) => NormalTextField(
                        controller: detailController,
                        placeHolder: 'Please enter your detail address',
                        onChanged: (String? value) {
                          _presenter.setDetailAddress(detail: value!);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: Platform.isIOS ? 13 : 17),
                  Selector<DetailAddressPresenter, bool>(
                    selector: (_, presenter) => presenter.isDefault,
                    builder: (_, isDefault, __) => Row(
                      children: [
                        InkWell(
                          onTap: () {
                            _presenter.setDefaultAddress(isDefault: !isDefault);
                          },
                          child: SvgPicture.asset(
                            isDefault
                                ? SvgPaths.iconAddressSelected
                                : SvgPaths.iconAddressUnSelected,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Make this my default address',
                          style: AppThemes.lightTheme.textTheme.headlineMedium!
                              .copyWith(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Platform.isIOS ? 13 : 17),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 18,
                      left: horizontalPaddingSubmitButton,
                      right: horizontalPaddingSubmitButton,
                      bottom: 0,
                    ),
                    child: Selector<DetailAddressPresenter, bool>(
                      selector: (_, presenter) => presenter.isFormValid,
                      builder: (_, isActive, __) => BRoundButton(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 11),
                        buttonName: 'Edit Address',
                        onClick: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _presenter.editAddress();
                        },
                        customTextStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                        isActive: isActive,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Selector<DetailAddressPresenter, bool>(
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
