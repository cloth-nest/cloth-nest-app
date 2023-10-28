import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/domain/usecases/profile/fetch_profile.dart';

class RemoteFetchProfile implements FetchProfile {
  final HttpClient httpClient;
  final String url;

  const RemoteFetchProfile({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<void> call() async {
    try {
      final httpResponse = await httpClient.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.get,
      );
      ResponseHandler.handle(httpResponse);
    } catch (e) {
      rethrow;
    }
  }
}
