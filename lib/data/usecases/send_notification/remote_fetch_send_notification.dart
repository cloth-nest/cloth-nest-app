// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/domain/usecases/send_notification/fetch_send_notification.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RemoteFetchSendNotification implements FetchSendNotification {
  final HttpClient client;
  final String url;
  RemoteFetchSendNotification({
    required this.client,
    required this.url,
  });

  @override
  Future<void> call({required String name, required String token}) async {
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode(
            {
              "data": {
                "title": "ClothNest Application",
                "content": '$name has created an order'
              },
              "to": token,
            },
          ),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAzTMNRRM:APA91bGDQvecy09xkxfaknJh1ymkcA6sEZtgchaCLE4qXdmvqdQRQO4_kXiK9yOqu1kbmh1eJCPg2ZK-DPmXuMCxRstVOWu8zYrCxXZeutMERyWh268ODmltfX_pw4aD9bPmJf2_GpjG',
          });
      debugPrint(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
