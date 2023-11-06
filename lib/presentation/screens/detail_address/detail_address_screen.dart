import 'dart:io';

import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/domain/entities/place/place_entity.dart';
import 'package:ecommerce/presentation/screens/add_address/add_address_presenter.dart';
import 'package:ecommerce/presentation/screens/add_address/widgets/w_combo_box.dart';
import 'package:ecommerce/presentation/screens/detail_address/detail_address_presenter.dart';
import 'package:ecommerce/presentation/widgets/button/b_round_button.dart';
import 'package:ecommerce/presentation/widgets/text_field/normal_text_field.dart';
import 'package:ecommerce/presentation/widgets/w_app_bar.dart';
import 'package:flutter/material.dart';
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
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController detailController = TextEditingController();

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
    _presenter.initData(idAddress: widget.idAddress);
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
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    mailController.dispose();
    detailController.dispose();

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
      appBar: const WAppBar(title: 'Add new address'),
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
                    child: NormalTextField(
                      controller: mailController,
                      focusNode: mailFocusNode,
                      nextFocus: firstNameFocusNode,
                      placeHolder: 'Please enter your email',
                      onChanged: (String? value) {
                        _presenter.setEmail(newEmail: value!);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: heightInputField,
                    child: NormalTextField(
                      controller: firstNameController,
                      focusNode: firstNameFocusNode,
                      nextFocus: lastNameFocusNode,
                      placeHolder: 'Please enter your first name',
                      onChanged: (String? value) {
                        _presenter.setFirstName(firstName: value!);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: heightInputField,
                    child: NormalTextField(
                      controller: lastNameController,
                      focusNode: lastNameFocusNode,
                      nextFocus: phoneFocusNode,
                      placeHolder: 'Please enter your last name',
                      onChanged: (String? value) {
                        _presenter.setLastName(lastName: value!);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: heightInputField,
                    child: NormalTextField(
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
                  const SizedBox(height: 16),
                  SizedBox(
                    height: heightInputField,
                    child: Selector<DetailAddressPresenter, List<PlaceEntity>>(
                      selector: (_, presenter) => presenter.provinces,
                      builder: (_, provinces, __) =>
                          Selector<DetailAddressPresenter, PlaceEntity?>(
                        selector: (_, presenter) => presenter.selectedProvince,
                        builder: (_, selectedProvince, __) => WComboBox(
                          callback: (newProvince) {
                            _presenter.setProvince(newProvince: newProvince);
                          },
                          source: provinces,
                          value: selectedProvince,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: heightInputField,
                    child: Selector<DetailAddressPresenter, List<PlaceEntity>>(
                      selector: (_, presenter) => presenter.districts,
                      builder: (_, districts, __) =>
                          Selector<DetailAddressPresenter, PlaceEntity?>(
                        selector: (_, presenter) => presenter.selectedDistrict,
                        builder: (_, selectedDistrict, __) => WComboBox(
                          callback: (newDistrict) {
                            _presenter.setDistrict(newDistrict: newDistrict);
                          },
                          source: districts,
                          value: selectedDistrict,
                        ),
                      ),
                    ),
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
                    child: NormalTextField(
                      controller: detailController,
                      placeHolder: 'Please enter your detail address',
                      onChanged: (String? value) {
                        _presenter.setDetailAddress(detail: value!);
                      },
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
                        buttonName: 'Done',
                        onClick: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          //_presenter.createAddress();
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
