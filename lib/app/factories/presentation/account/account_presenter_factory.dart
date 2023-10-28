import 'package:ecommerce/app/factories/usecases/authentication/logout/logout_factory.dart';
import 'package:ecommerce/app/factories/usecases/token/token_factory.dart';
import 'package:ecommerce/presentation/presenters/account/account_state.dart';
import 'package:ecommerce/presentation/presenters/account/provider_account_presenter.dart';
import 'package:ecommerce/presentation/screens/account/account_presenter.dart';

AccountPresenter makeAccountPresenter() => ProviderAccountPresenter(
      state: AccountState.initial(),
      fetchToken: makeFetchLocalToken(),
      fetchRemoteLogout: makeRemoteFetchLogout(),
      fetchLocalLogout: makeLocalFetchLogout(),
    );
