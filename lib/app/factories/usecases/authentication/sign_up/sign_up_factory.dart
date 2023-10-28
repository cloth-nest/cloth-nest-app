import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/authentication/sign_up/remote_fetch_sign_up.dart';
import 'package:ecommerce/domain/usecases/authentication/sign_up/fetch_sign_up.dart';

FetchSignUp makeFetchSignUp() => RemoteFetchSignUp(
      httpClient: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('auth/sign-up'),
    );
