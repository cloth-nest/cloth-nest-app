import 'package:ecommerce/app/factories/usecases/detail_address/fetch_detail_address_factory.dart';
import 'package:ecommerce/app/factories/usecases/place/place_factory.dart';
import 'package:ecommerce/presentation/presenters/detail_address/detail_address_state.dart';
import 'package:ecommerce/presentation/presenters/detail_address/provider_detail_address_presenter.dart';
import 'package:ecommerce/presentation/screens/detail_address/detail_address_presenter.dart';

DetailAddressPresenter makeDetailAddressPresenter() =>
    ProviderDetailAddressPresenter(
      state: DetailAddressState.initial(),
      fetchDetailAddress: makeFetchDetailAddress(),
      fetchDistricts: makeFetchDistricts(),
      fetchWards: makeFetchWards(),
      fetchProvinces: makeFetchProvinces(),
    );
