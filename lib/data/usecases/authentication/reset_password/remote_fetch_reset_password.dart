import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/usecases/authentication/reset_password/remote_reset_password_params.dart';
import 'package:ecommerce/domain/usecases/authentication/reset_password/fetch_reset_password.dart';
import 'package:ecommerce/domain/usecases/authentication/reset_password/reset_password_params.dart';

class RemoteFetchResetPassword implements FetchResetPassword {
  final HttpClient httpClient;
  final String url;

  const RemoteFetchResetPassword({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<void> call({required ResetPasswordParams params}) async {
    RemoteResetPasswordParams resetPasswordParams =
        RemoteResetPasswordParams.fromDomain(params);

    try {
      final httpResponse = await httpClient.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.post,
        body: resetPasswordParams.toJson(),
      );
      ResponseHandler.handle(httpResponse);
    } catch (e) {
      rethrow;
    }
  }
}
