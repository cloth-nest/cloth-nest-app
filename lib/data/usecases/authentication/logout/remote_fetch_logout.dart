import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/usecases/authentication/logout/remote_logout_params.dart';
import 'package:ecommerce/domain/usecases/authentication/logout/fetch_logout.dart';
import 'package:ecommerce/domain/usecases/authentication/logout/logout_params.dart';

class RemoteFetchLogout implements FetchLogout {
  final String url;
  final HttpClient client;

  RemoteFetchLogout({
    required this.client,
    required this.url,
  });

  @override
  Future<void> call({LogoutParams? params}) async {
    try {
      final RemoteLogoutParams remoteLogoutParams =
          RemoteLogoutParams.fromDomain(params!);

      final response = await client.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.post,
        body: remoteLogoutParams.toJson(),
      );
      ResponseHandler.handle(response);
    } catch (e) {
      rethrow;
    }
  }
}
