import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/bill/remote_fetch_calculate_bill.dart';
import 'package:ecommerce/domain/usecases/bill/fetch_calculate_bill.dart';

FetchCalculateBill makeFetchCalculateBill() => RemoteFetchCalculateBill(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('order/calc-bill'),
    );
