import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/update_profie/remote_fetch_update_profile.dart';
import 'package:ecommerce/domain/usecases/update_profile/fetch_update_profile.dart';

FetchUpdateProfile makeFetchUpdateProfile() => RemoteFetchUpdateProfile(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('user/profile'),
    );
