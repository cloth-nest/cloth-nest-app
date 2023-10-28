import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/authentication/login/remote_fetch_login.dart';
import 'package:ecommerce/domain/usecases/authentication/login/fetch_login.dart';

FetchLogin makeFetchLogin() => RemoteFetchLogin(
      httpClient: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('auth/sign-in'),
    );
