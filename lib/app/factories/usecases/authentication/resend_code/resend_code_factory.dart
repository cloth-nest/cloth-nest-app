import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/authentication/resend_code/remote_fetch_resend_code.dart';
import 'package:ecommerce/domain/usecases/authentication/resend_code/fetch_resend_code.dart';

FetchResendCode makeFetchResendCode() => RemoteFetchResendCode(
      httpClient: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('auth/resend-code'),
    );
