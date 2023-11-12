import 'package:ecommerce/app/factories/usecases/delete_address/fetch_delete_address_factory.dart';
import 'package:ecommerce/app/factories/usecases/fetch_address/fetch_address_factory.dart';
import 'package:ecommerce/presentation/presenters/address/address_state.dart';
import 'package:ecommerce/presentation/presenters/address/provider_address_presenter.dart';
import 'package:ecommerce/presentation/screens/address/address_presenter.dart';

AddressPresenter makeAddressPresenter() => ProviderAddressPresenter(
      state: AddressState.initial(),
      fetchAddress: makeFetchAddress(),
      fetchDeleteAddress: makeFetchDeleteAddress(),
    );
