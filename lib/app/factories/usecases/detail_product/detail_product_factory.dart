import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/detail_product/remote_fetch_detail_product.dart';
import 'package:ecommerce/domain/usecases/detail_product/fetch_detail_product.dart';

FetchDetailProduct makeFetchDetailProduct() => RemoteFetchDetailProduct(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('product'),
    );
