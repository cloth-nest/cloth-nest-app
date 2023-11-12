import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/profile/remote_fetch_profile.dart';
import 'package:ecommerce/domain/usecases/profile/fetch_profile.dart';

FetchProfile makeFetchProfile() => RemoteFetchProfile(
      httpClient: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('user/profile'),
    );
