import 'package:ecommerce/presentation/presenters/top/provider_top_presenter.dart';
import 'package:ecommerce/presentation/presenters/top/top_state.dart';
import 'package:ecommerce/presentation/screens/top/top_presenter.dart';

TopPresenter makeTopPresenter() => ProviderTopPresenter(
      state: TopState.initial(),
    );
