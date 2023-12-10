import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/product_type/remote_fetch_product_type.dart';
import 'package:ecommerce/domain/usecases/product_type/fetch_product_type.dart';

FetchProductType makeFetchProductType() => RemoteFetchProductType(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('product/types?limit=0&page=1'),
    );
