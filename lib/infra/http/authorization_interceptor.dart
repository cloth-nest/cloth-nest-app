import 'package:http_interceptor/http_interceptor.dart';

class AuthorizationInterceptor implements InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    /// TODO: get accessToken from local

    //final userSession = UserSessionSingleton().latestUserSession;
    //final accessToken = userSession?.accessToken ?? '';
    const accessToken = '';

    final authHeader = {
      'token': accessToken,
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
