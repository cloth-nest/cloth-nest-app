import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/user/user_model.dart';
import 'package:ecommerce/domain/entities/user/user_entity.dart';
import 'package:ecommerce/domain/usecases/profile/fetch_profile.dart';

class RemoteFetchProfile implements FetchProfile {
  final HttpClient httpClient;
  final String url;

  const RemoteFetchProfile({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<UserEntity> call() async {
    try {
      final httpResponse = await httpClient.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.get,
      );
      final json = ResponseHandler.handle(httpResponse);
      UserModel userModel = UserModel.fromJson(json['data']);
      return userModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }
}
