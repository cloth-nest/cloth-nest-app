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
  }) async {
    try {
      final response = await client.makeRequest(
        uri: Uri.parse(url),
        method: HttpMethod.post,
        body: {
          'ghnServerTypeId': ghnServerTypeId,
          'addressId': addressId,
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
