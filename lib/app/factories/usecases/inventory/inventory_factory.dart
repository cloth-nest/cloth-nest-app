import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/inventory/remote_fetch_inventory.dart';
import 'package:ecommerce/domain/usecases/inventory/fetch_inventory.dart';

FetchInventory makeFetchInventory() => RemoteFetchInventory(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('order/check-inventory'),
    );
