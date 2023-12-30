import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/domain/usecases/authentication/firebase_token/fetch_firebase_token.dart';

class RemoteFetchFirebaseToken implements FetchFirebaseToken {
  final HttpClient httpClient;
  final String url;

  const RemoteFetchFirebaseToken({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<String> call({required String email}) async {
    try {
      final httpResponse = await httpClient.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.post,
        body: {
          'email': email,
        },
      );
      final jsonResponse = ResponseHandler.handle(httpResponse);

      return jsonResponse['data']['firebaseToken'];
    } catch (e) {
      rethrow;
    }
  }
}
