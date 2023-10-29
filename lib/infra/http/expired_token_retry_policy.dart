import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:http_interceptor/http_interceptor.dart';

enum SessionUpdateStatus { outdated, updated, deleted }

class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  int get maxRetryAttempts => 1;

  /*
  // Nếu bị lỗi 401 thì khi nào cho phép Retry?
  // 1. API đầu tiên bị 401 sẽ kiểm tra để call Auto login
  // 2. Nếu thành công thì update lại token và return true để retry
  // 3. Nếu thất bại thì return false, nếu throw exception thì bên ngoài có thấy không
   */

  @override
  Future<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {
    if (response.statusCode == 401) {
      return await lock.synchronized(() async {
        return await handleRefreshToken();
      });
    } else if (response.statusCode == 200 || response.statusCode == 204) {
      return await lock.synchronized(() async {
        return await handleExpireDateApi();
      });
    }
    return false;
  }

  handleRefreshToken() {
    return false;
  }

  handleExpireDateApi() {
    return false;
  }
}
