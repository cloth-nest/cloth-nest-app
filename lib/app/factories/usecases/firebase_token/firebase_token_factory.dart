import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/authentication/firebase_token/remote_fetch_firebase_token.dart';
import 'package:ecommerce/domain/usecases/authentication/firebase_token/fetch_firebase_token.dart';

FetchFirebaseToken makeFetchFirebaseToken() => RemoteFetchFirebaseToken(
      httpClient: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('user/ft'),
    );
