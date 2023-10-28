import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/authentication/forget_password/remote_fetch_forget_password.dart';
import 'package:ecommerce/domain/usecases/authentication/forget_password/fetch_forget_password.dart';

FetchForgetPassword makeRemoteFetchForgetPassword() =>
    RemoteFetchForgetPassword(
      httpClient: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('auth/forget-password'),
    );
