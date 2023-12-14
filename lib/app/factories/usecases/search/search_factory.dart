import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/search/remote_fetch_search.dart';
import 'package:ecommerce/domain/usecases/search/fetch_search.dart';

FetchSearch makeRemoteFetchSearch() => RemoteFetchSearch(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('product/search'),
    );
