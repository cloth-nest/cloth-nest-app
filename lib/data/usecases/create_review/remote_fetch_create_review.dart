// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:ecommerce/app/factories/usecases/token/token_factory.dart';
import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/usecases/token/constants.dart';
import 'package:ecommerce/domain/entities/token/token_entity.dart';
import 'package:ecommerce/domain/usecases/create_review/fetch_create_review.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/src/media_type.dart';
import 'package:mime/mime.dart';

class RemoteFetchCreateReview implements FetchCreateReview {
  final HttpClient client;
  final String url;
  RemoteFetchCreateReview({
    required this.client,
    required this.url,
  });

  @override
  Future<void> call({
    required int idProduct,
    required String reviewContent,
    required double rating,
    required List<File> files,
  }) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse('$url/$idProduct'))
        ..fields['reviewContent'] = reviewContent
        ..fields['rating'] = rating.toString();

      for (var file in files) {
        final mimeTypeData =
            lookupMimeType(file.path, headerBytes: [0xFF, 0xD8])!.split('/');

        request.files.add(
          http.MultipartFile.fromBytes(
            'files',
            file.readAsBytesSync(),
            filename: 'abc${file.path}',
            contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
          ),
        );
      }

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
      debugPrint('fetch create image: $json');
    } catch (e) {
      rethrow;
    }
  }
}
