import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/delete_address/remote_delete_address.dart';
import 'package:ecommerce/domain/usecases/delete_address/fetch_delete_address.dart';

FetchDeleteAddress makeFetchDeleteAddress() => RemoteFetchDeleteAddress(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('address'),
    );
