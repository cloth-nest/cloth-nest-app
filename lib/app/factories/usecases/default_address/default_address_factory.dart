import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/default_address/remote_fetch_default_address.dart';
import 'package:ecommerce/domain/usecases/default_address/fetch_default_address.dart';

FetchDefaultAddress makeFetchDefaultAddress() => RemoteFetchDefaultAddress(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('address/default'),
    );
