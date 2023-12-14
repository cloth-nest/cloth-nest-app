import 'package:ecommerce/app/factories/usecases/history_search/history_search_factory.dart';
import 'package:ecommerce/presentation/presenters/search_shared/provider_search_shared_presenter.dart';
import 'package:ecommerce/presentation/presenters/search_shared/search_shared_state.dart';
import 'package:ecommerce/presentation/screens/search_shared/search_shared_presenter.dart';

SearchSharedPresenter makeSearchSharedPresenter() =>
    ProviderSearchSharedPresenter(
      state: SearchSharedState.initial(),
      saveHistorySearch: makeSaveHistorySearch(),
      fetchHistorySearch: makeFetchHistorySearch(),
    );
