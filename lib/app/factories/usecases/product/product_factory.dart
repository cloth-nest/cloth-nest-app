import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/product/remote_fetch_product.dart';
import 'package:ecommerce/domain/usecases/product/fetch_product.dart';

FetchProduct makeFetchProduct() => RemoteFetchProduct(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('product/category'),
    );
