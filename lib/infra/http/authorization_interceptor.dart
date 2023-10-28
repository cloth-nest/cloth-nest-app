import 'package:ecommerce/app/factories/usecases/token/token_factory.dart';
import 'package:ecommerce/data/usecases/token/constants.dart';
import 'package:ecommerce/domain/entities/token/token_entity.dart';
import 'package:http_interceptor/http_interceptor.dart';

class AuthorizationInterceptor implements InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    final TokenEntity? token =
        await makeFetchLocalToken().call(key: uniqueUserTokenKey);
    final accessToken = token?.accessToken;

    final authHeader = {
      'Authorization': 'Bearer $accessToken',
    };

    authHeader.removeWhere((key, value) => value.isEmpty);
    request.headers.addAll(authHeader);

    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    return response;
  }

  @override
  Future<bool> shouldInterceptRequest() async {
    return true;
  }

  @override
  Future<bool> shouldInterceptResponse() async {
    return true;
  }
}
