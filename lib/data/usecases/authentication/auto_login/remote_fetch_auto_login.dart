import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/token/token_model.dart';
import 'package:ecommerce/data/usecases/authentication/auto_login/remote_auto_login_params.dart';
import 'package:ecommerce/domain/entities/token/token_entity.dart';
import 'package:ecommerce/domain/usecases/authentication/auto_login/auto_login_params.dart';
import 'package:ecommerce/domain/usecases/authentication/auto_login/fetch_auto_login.dart';

class RemoteFetchAutoLogin implements FetchAutoLogin {
  final String url;
  final HttpClient client;

  RemoteFetchAutoLogin({
    required this.client,
    required this.url,
  });

  @override
  Future<TokenEntity> call({required AutoLoginParams params}) async {
    try {
      final RemoteAutoLoginParams remoteAutoLoginParams =
          RemoteAutoLoginParams.fromDomain(params);

      final httpResponse = await client.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.post,
        body: remoteAutoLoginParams.toJson(),
      );
      final jsonResponse = ResponseHandler.handle(httpResponse);
      final tokenModel = TokenModel.fromMap(jsonResponse['data']);
      final tokenEntity = tokenModel.toEntity();
      return tokenEntity;
    } catch (e) {
      rethrow;
    }
  }
}
