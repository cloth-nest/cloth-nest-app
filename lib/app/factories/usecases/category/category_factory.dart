import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/category/remote_fetch_category.dart';
import 'package:ecommerce/domain/usecases/category/fetch_master_category.dart';

FetchCategory makeFetchCategory() => RemoteFetchCategory(
      httpClient: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('category'),
    );
