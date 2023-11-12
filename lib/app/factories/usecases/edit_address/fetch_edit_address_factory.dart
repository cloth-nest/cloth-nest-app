import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/edit_address/remote_fetch_edit_address.dart';
import 'package:ecommerce/domain/usecases/edit_address/fetch_edit_address.dart';

FetchEditAddress makeFetchEditAddress() => RemoteFetchEditAddress(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('address'),
    );
