import 'package:ecommerce/app/factories/usecases/history_search/history_search_factory.dart';
import 'package:ecommerce/presentation/presenters/search/provider_search_presenter.dart';
import 'package:ecommerce/presentation/presenters/search/search_state.dart';
import 'package:ecommerce/presentation/screens/search/search_presenter.dart';

SearchPresenter makeSearchPresenter() {
  return ProviderSearchPresenter(
    state: SearchState.initial(),
    saveHistorySearch: makeSaveHistorySearch(),
    fetchHistorySearch: makeFetchHistorySearch(),
  );
}
