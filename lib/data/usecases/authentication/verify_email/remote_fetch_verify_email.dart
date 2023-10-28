import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/token/token_model.dart';
import 'package:ecommerce/data/usecases/authentication/verify_email/remote_verify_email_params.dart';
import 'package:ecommerce/domain/entities/token/token_entity.dart';
import 'package:ecommerce/domain/usecases/authentication/verify_email/fetch_verify_email.dart';
import 'package:ecommerce/domain/usecases/authentication/verify_email/verify_email_params.dart';

class RemoteFetchVerifyEmail implements FetchVerifyEmail {
  final HttpClient httpClient;
  final String url;

  const RemoteFetchVerifyEmail({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<TokenEntity> call({required VerifyEmailParams params}) async {
    RemoteVerifyEmailParams verifyEmailParams =
        RemoteVerifyEmailParams.fromDomain(params);

    try {
      final httpResponse = await httpClient.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.post,
        body: verifyEmailParams.toJson(),
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
