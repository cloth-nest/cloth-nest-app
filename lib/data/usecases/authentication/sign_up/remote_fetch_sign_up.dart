import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/usecases/authentication/sign_up/remote_sign_up_params.dart';
import 'package:ecommerce/domain/usecases/authentication/sign_up/fetch_sign_up.dart';
import 'package:ecommerce/domain/usecases/authentication/sign_up/sign_up_params.dart';

class RemoteFetchSignUp implements FetchSignUp {
  final HttpClient httpClient;
  final String url;

  const RemoteFetchSignUp({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<void> call({required SignUpParams params}) async {
    RemoteSignUpParams signUpParams = RemoteSignUpParams.fromDomain(params);

    try {
      final httpResponse = await httpClient.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.post,
        body: signUpParams.toJson(),
      );
      ResponseHandler.handle(httpResponse);
    } catch (e) {
      rethrow;
    }
  }
}
