import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/usecases/authentication/forget_password/remote_forget_password_params.dart';
import 'package:ecommerce/domain/usecases/authentication/forget_password/fetch_forget_password.dart';
import 'package:ecommerce/domain/usecases/authentication/forget_password/forget_password_params.dart';

class RemoteFetchForgetPassword implements FetchForgetPassword {
  final HttpClient httpClient;
  final String url;

  const RemoteFetchForgetPassword({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<void> call({required ForgetPasswordParams params}) async {
    RemoteForgetPasswordParams forgetPasswordParams =
        RemoteForgetPasswordParams.fromDomain(params);

    try {
      final response = await httpClient.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.post,
        body: forgetPasswordParams.toJson(),
      );
      ResponseHandler.handle(response);
    } catch (e) {
      rethrow;
    }
  }
}
