import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/authentication/auto_login/remote_fetch_auto_login.dart';
import 'package:ecommerce/domain/usecases/authentication/auto_login/fetch_auto_login.dart';

FetchAutoLogin makeFetchAutoLogin() => RemoteFetchAutoLogin(
      client: makeHttpAdapter(),
      url: makeApiUrl('auth/refresh-token/'),
    );
