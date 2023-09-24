import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/token/token_model.dart';
import 'package:ecommerce/data/usecases/authentication/login/remote_login_params.dart';
import 'package:ecommerce/domain/entities/token/token_entity.dart';
import 'package:ecommerce/domain/usecases/authentication/login/fetch_login.dart';
import 'package:ecommerce/domain/usecases/authentication/login/login_params.dart';

class RemoteFetchLogin implements FetchLogin {
  final HttpClient httpClient;
  final String url;

  const RemoteFetchLogin({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<TokenEntity> call({required LoginParams loginParams}) async {
    RemoteLoginParams params = RemoteLoginParams.fromDomain(loginParams);

    try {
      final httpResponse = await httpClient.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.post,
        body: params.toJson(),
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
