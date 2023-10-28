import 'package:async/async.dart';
import 'package:ecommerce/data/usecases/token/constants.dart';
import 'package:ecommerce/domain/entities/token/token_entity.dart';
import 'package:ecommerce/domain/usecases/token/fetch_token.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'dart:async';

class CancelableInterceptor implements InterceptorContract {
  late CancelableOperation<BaseRequest> _operation;
  final FetchToken fetchToken;

  CancelableInterceptor({
    required this.fetchToken,
  });

  void cancelRequest() {
    if (!_operation.isCompleted) {
      _operation.cancel();
    }
  }

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    final TokenEntity? tokenEntity =
        await fetchToken.call(key: uniqueUserTokenKey);

    if (tokenEntity == null || tokenEntity.isRemember == false) {
      return request;
    }
    _operation = CancelableOperation.fromFuture(Future.value(request));
    final validAccessToken = await _validateAccessToken(request);
    if (!validAccessToken) {
      cancelRequest();
    }
    return await _operation.value;
  }

  Future<bool> _validateAccessToken(BaseRequest request) async {
    final headers = request.headers;
    final requestAccessToken = headers['Authorization'];
    // nếu từ đầu đã null thì không cần check
    if (requestAccessToken == null) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> shouldInterceptRequest() async {
    return true;
  }

  @override
  Future<bool> shouldInterceptResponse() async {
    return false;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    return response;
  }
}
