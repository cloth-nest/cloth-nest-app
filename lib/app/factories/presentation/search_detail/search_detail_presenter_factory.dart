import 'package:ecommerce/app/factories/usecases/search/search_factory.dart';
import 'package:ecommerce/app/factories/usecases/wishlist/delete_wish_list_factory.dart';
import 'package:ecommerce/app/factories/usecases/wishlist/fetch_wish_list_factory.dart';
import 'package:ecommerce/app/factories/usecases/wishlist/save_wish_list_factory.dart';
import 'package:ecommerce/presentation/presenters/search_detail/provider_search_detail_presenter.dart';
import 'package:ecommerce/presentation/presenters/search_detail/search_detail_state.dart';
import 'package:ecommerce/presentation/screens/search_detail.dart/search_detail_presenter.dart';

SearchDetailPresenter makeSearchDetailPresenter() {
  return ProviderSearchDetailPresenter(
    state: SearchDetailState.initial(),
    fetchSearch: makeRemoteFetchSearch(),
    saveWishlist: makeSaveWishList(),
    deleteWishlist: makeDeleteWishlist(),
    fetchWishlist: makeFetchWishlist(),
    saveRemoteWishlist: makeRemoteSaveWishList(),
    fetchRemoteWishlist: makeRemoteFetchWishlist(),
    deleteRemoteWishlist: makeRemoteDeleteWishList(),
  );
}
