import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/fetch_address/remote_fetch_address.dart';
import 'package:ecommerce/domain/usecases/fetch_address/fetch_address.dart';

FetchAddress makeFetchAddress() => RemoteFetchAddress(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('address'),
    );
