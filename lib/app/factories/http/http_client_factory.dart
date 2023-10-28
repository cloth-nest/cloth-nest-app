import 'package:ecommerce/app/factories/usecases/authentication/auto_login/auto_login_factory.dart';
import 'package:ecommerce/app/factories/usecases/authentication/logout/logout_factory.dart';
import 'package:ecommerce/app/factories/usecases/token/token_factory.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/infra/http/authorization_interceptor.dart';
import 'package:ecommerce/infra/http/cancelable_interceptor.dart';
import 'package:ecommerce/infra/http/expired_token_retry_policy.dart';
import 'package:ecommerce/infra/http/http_adapter.dart';
import 'package:ecommerce/infra/http/logger_interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:synchronized/synchronized.dart';

var lock = Lock();
final headerVersionLock = Lock();
int count = 0;

HttpClient makeHttpAdapter() => HttpAdapter(Client());

InterceptorContract makeAuthorizationInterceptor() =>
    AuthorizationInterceptor();

HttpClient makeHttpAuthorizedAdapter() {
  final client = InterceptedClient.build(
    interceptors: [
      //CancelableInterceptor(fetchToken: makeFetchLocalToken()),
      makeAuthorizationInterceptor(),
      LoggerInterceptor(),
    ],
    retryPolicy: makeExpiredTokenRetryPolicy(),
  );
  return HttpAdapter(client);
}

RetryPolicy makeExpiredTokenRetryPolicy() {
  return ExpiredTokenRetryPolicy(
    fetchAutoLogin: makeFetchAutoLogin(),
    fetchLogout: makeLocalFetchLogout(),
    fetchToken: makeFetchLocalToken(),
    saveToken: makeSaveLocalToken(),
  );
}
