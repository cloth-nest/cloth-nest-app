import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/authentication/reset_password/remote_fetch_reset_password.dart';
import 'package:ecommerce/domain/usecases/authentication/reset_password/fetch_reset_password.dart';

FetchResetPassword makeFetchResetPassword() => RemoteFetchResetPassword(
      httpClient: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('auth/reset-password'),
    );
