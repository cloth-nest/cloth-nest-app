import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/detail_address/remote_fetch_detail_address.dart';
import 'package:ecommerce/domain/usecases/detail_address/fetch_detail_address.dart';

FetchDetailAddress makeFetchDetailAddress() => RemoteFetchDetailAddress(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('address'),
    );
