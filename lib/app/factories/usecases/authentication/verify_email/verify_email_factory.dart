import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/authentication/verify_email/remote_fetch_verify_email.dart';
import 'package:ecommerce/domain/usecases/authentication/verify_email/fetch_verify_email.dart';

FetchVerifyEmail makeFetchVerifyEmail() => RemoteFetchVerifyEmail(
      httpClient: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('auth/verify-email-sign-in'),
    );

FetchVerifyEmail makeFetchVerifyEmailForgetPassword() => RemoteFetchVerifyEmail(
      httpClient: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('auth/verify-forget-password'),
    );
