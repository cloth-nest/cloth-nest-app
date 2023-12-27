import 'package:ecommerce/app/factories/usecases/detail_product/detail_product_factory.dart';
import 'package:ecommerce/app/factories/usecases/qr_code/qr_code_factory.dart';
import 'package:ecommerce/presentation/presenters/qr_code/provider_qr_code_presenter.dart';
import 'package:ecommerce/presentation/presenters/qr_code/qr_code_state.dart';
import 'package:ecommerce/presentation/screens/qr_code/qr_code_presenter.dart';
import 'package:ecommerce/app/factories/usecases/wishlist/delete_wish_list_factory.dart';
import 'package:ecommerce/app/factories/usecases/wishlist/fetch_wish_list_factory.dart';
import 'package:ecommerce/app/factories/usecases/wishlist/save_wish_list_factory.dart';

QrCodePresenter makeQrCodePresenter() => ProviderQrCodePresenter(
      state: QrCodeState.initial(),
      fetchDetailProduct: makeFetchDetailProduct(),
      saveWishlist: makeSaveWishList(),
      deleteWishlist: makeDeleteWishlist(),
      fetchWishlist: makeFetchWishlist(),
      saveRemoteWishlist: makeRemoteSaveWishList(),
      fetchRemoteWishlist: makeRemoteFetchWishlist(),
      deleteRemoteWishlist: makeRemoteDeleteWishList(),
      saveHistoryQrCode: makeSaveHistoryQrCode(),
      deleteHistoryQrCode: makeDeleteHistoryQrCode(),
      fetchHistoryQrCode: makeFetchHistoryQrCode(),
    );
