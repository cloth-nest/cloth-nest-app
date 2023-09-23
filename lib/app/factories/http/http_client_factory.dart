import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/infra/http/authorization_interceptor.dart';
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
      makeAuthorizationInterceptor(),
      LoggerInterceptor(),
    ],
  );
  return HttpAdapter(client);
}
