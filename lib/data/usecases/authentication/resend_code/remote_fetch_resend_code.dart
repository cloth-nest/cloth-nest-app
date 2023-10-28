import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/usecases/authentication/resend_code/remote_resend_code_params.dart';
import 'package:ecommerce/domain/usecases/authentication/resend_code/fetch_resend_code.dart';
import 'package:ecommerce/domain/usecases/authentication/resend_code/resend_code_params.dart';

class RemoteFetchResendCode implements FetchResendCode {
  final HttpClient httpClient;
  final String url;

  const RemoteFetchResendCode({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<void> call({required ResendCodeParams params}) async {
    RemoteResendCodeParams resendCodeParams =
        RemoteResendCodeParams.fromDomain(params);

    try {
      final httpResponse = await httpClient.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.post,
        body: resendCodeParams.toJson(),
      );
      ResponseHandler.handle(httpResponse);
    } catch (e) {
      rethrow;
    }
  }
}
