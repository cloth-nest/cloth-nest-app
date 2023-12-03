import 'package:ecommerce/app/factories/usecases/update_profile/update_profile_factory.dart';
import 'package:ecommerce/app/factories/usecases/upload_avatar/upload_avatar_factory.dart';
import 'package:ecommerce/presentation/presenters/profile/profile_state.dart';
import 'package:ecommerce/presentation/presenters/profile/provider_profile_presenter.dart';
import 'package:ecommerce/presentation/screens/profile/profile_presenter.dart';

ProfilePresenter makeProfilePresenter() => ProviderProfilePresenter(
      state: ProfileState.initial(),
      fetchUpdateProfile: makeFetchUpdateProfile(),
      fetchUploadAvatar: makeFetchUploadAvatar(),
    );
