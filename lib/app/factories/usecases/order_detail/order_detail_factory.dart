import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/order_detail/remote_fetch_order_detail.dart';
import 'package:ecommerce/domain/usecases/order_detail/fetch_order_detail.dart';

FetchOrderDetail makeFetchOrderDetail() => RemoteFetchOrderDetail(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('order'),
    );
