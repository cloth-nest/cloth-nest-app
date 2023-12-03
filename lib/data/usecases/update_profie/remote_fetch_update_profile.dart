import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/usecases/update_profie/remote_update_profile_params.dart';

import 'package:ecommerce/domain/usecases/update_profile/fetch_update_profile.dart';
import 'package:ecommerce/domain/usecases/update_profile/update_profile_params.dart';

class RemoteFetchUpdateProfile implements FetchUpdateProfile {
  final String url;
  final HttpClient client;

  RemoteFetchUpdateProfile({
    required this.client,
    required this.url,
  });

  @override
  Future<void> call({required UpdateProfileParams params}) async {
    try {
      final RemoteUpdateProfileParams remoteUpdateProfileParams =
          RemoteUpdateProfileParams.fromDomain(params);

      final httpResponse = await client.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.patch,
        body: remoteUpdateProfileParams.toJson(),
      );
      ResponseHandler.handle(httpResponse);
    } catch (e) {
      rethrow;
    }
  }
}
