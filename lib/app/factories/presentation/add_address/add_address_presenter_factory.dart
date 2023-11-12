import 'package:ecommerce/app/factories/usecases/add_address/add_address_factory.dart';
import 'package:ecommerce/app/factories/usecases/place/place_factory.dart';
import 'package:ecommerce/presentation/presenters/add_address/add_address_state.dart';
import 'package:ecommerce/presentation/presenters/add_address/provider_add_address_presenter.dart';
import 'package:ecommerce/presentation/screens/add_address/add_address_presenter.dart';

AddAddressPresenter makeAddAddressPresenter() => ProviderAddAddressPresenter(
      state: AddAddressState.initial(),
      fetchProvinces: makeFetchProvinces(),
      fetchDistricts: makeFetchDistricts(),
      fetchWards: makeFetchWards(),
      fetchCreateAddress: makeFetchCreateAddress(),
    );
