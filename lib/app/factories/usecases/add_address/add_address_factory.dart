import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/create_address/remote_fetch_create_address.dart';
import 'package:ecommerce/domain/usecases/create_address/fetch_create_address.dart';

FetchCreateAddress makeFetchCreateAddress() => RemoteFetchCreateAddress(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('address'),
    );
