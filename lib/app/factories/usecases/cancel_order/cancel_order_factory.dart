import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/cancel_order/remote_fetch_cancel_order.dart';
import 'package:ecommerce/domain/usecases/cancel_order/fetch_cancel_order.dart';

FetchCancelOrder makeFetchCancelOrder() => RemoteFetchCancelOrder(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('order/cancel'),
    );
