import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/data/helper/response_handler.dart';
import 'package:ecommerce/data/http/http_client.dart';
import 'package:ecommerce/data/models/bill/bill_model.dart';
import 'package:ecommerce/domain/entities/bill/bill_entity.dart';
import 'package:ecommerce/domain/usecases/bill/fetch_calculate_bill.dart';

class RemoteFetchCalculateBill implements FetchCalculateBill {
  final HttpClient client;
  final String url;

  RemoteFetchCalculateBill({
    required this.client,
    required this.url,
  });

  @override
  Future<BillEntity> call({
    required int addressId,
    required int ghnServerTypeId,
    Map<String, dynamic>? carts,
  }) async {
    try {
      final response = await client.makeRequest(
        uri: carts != null
            ? Uri.parse(makeApiUrl('order/calc-bill-without-cart'))
            : Uri.parse(url),
        method: HttpMethod.post,
        body: carts == null
            ? {
                'ghnServerTypeId': ghnServerTypeId,
                'addressId': addressId,
              }
            : {
                'ghnServerTypeId': ghnServerTypeId,
                'addressId': addressId,
                'carts': [carts],
              },
      );
      final json = ResponseHandler.handle(response);
      final BillEntity entity =
          BillModel.fromMap(json['data']['bill']).toEntity();

      return entity;
    } catch (e) {
      rethrow;
    }
  }
}
