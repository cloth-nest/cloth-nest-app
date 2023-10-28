import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/app/factories/usecases/token/token_factory.dart';
import 'package:ecommerce/data/usecases/authentication/logout/local_fetch_logout.dart';
import 'package:ecommerce/data/usecases/authentication/logout/remote_fetch_logout.dart';
import 'package:ecommerce/domain/usecases/authentication/logout/fetch_logout.dart';

FetchLogout makeRemoteFetchLogout() => RemoteFetchLogout(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('auth/sign-out'),
    );

FetchLogout makeLocalFetchLogout() => LocalFetchLogout(
      deleteToken: makeDeleteLocalToken(),
    );
