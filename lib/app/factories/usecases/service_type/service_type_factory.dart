import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/service_type/remote_fetch_service_type.dart';
import 'package:ecommerce/domain/usecases/service_type/fetch_service_type.dart';

FetchServiceType makeFetchServiceType() => RemoteFetchServiceType(
      client: makeHttpAuthorizedAdapter(),
      url:
          'https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/available-services',
    );
