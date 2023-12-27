import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/checkout/remote_fetch_checkout.dart';
import 'package:ecommerce/domain/usecases/checkout/fetch_checkout.dart';

FetchCheckOut makeFetchCheckOut() => RemoteFetchCheckOut(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('order'),
    );
