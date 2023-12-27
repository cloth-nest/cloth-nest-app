import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/order/remote_fetch_order.dart';
import 'package:ecommerce/domain/usecases/order/fetch_order.dart';

FetchOrder makeFetchOrder() => RemoteFetchOrder(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('order'),
    );
