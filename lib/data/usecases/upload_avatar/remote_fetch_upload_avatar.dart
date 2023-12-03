import 'dart:io';

import 'package:ecommerce/app/factories/usecases/token/token_factory.dart';
import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/usecases/token/constants.dart';
import 'package:ecommerce/domain/entities/token/token_entity.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/domain/usecases/upload_avatar/fetch_upload_avatar.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:mime/mime.dart';

class RemoteFetchUploadAvatar implements FetchUploadAvatar {
  final String url;

  RemoteFetchUploadAvatar({
    required this.url,
  });

  @override
  Future<String> call({required File file}) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));

      final mimeTypeData =
          lookupMimeType(file.path, headerBytes: [0xFF, 0xD8])!.split('/');

      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          file.readAsBytesSync(),
          filename: 'abc',
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        ),
      );

      final TokenEntity? token =
          await makeFetchLocalToken().call(key: uniqueUserTokenKey);
      final accessToken = token?.accessToken;

      final authHeader = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'multipart/form-data',
        'Accept': '*/*',
      };

      request.headers.addAll(authHeader);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      final json = ResponseHandler.handle(response);
      return json['data']['avatarUrl'];
    } catch (e) {
      rethrow;
    }
  }
}
