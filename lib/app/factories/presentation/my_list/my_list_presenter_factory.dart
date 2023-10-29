import 'package:ecommerce/presentation/presenters/my_list/my_list_state.dart';
import 'package:ecommerce/presentation/presenters/my_list/provider_my_list_presenter.dart';
import 'package:ecommerce/presentation/screens/my_list/my_list_presenter.dart';

MyListPresenter makeMyListPresenter() => ProviderMyListPresenter(
      state: MyListState.initial(),
    );
