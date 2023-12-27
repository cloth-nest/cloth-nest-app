import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/payment/remote_fetch_payment.dart';
import 'package:ecommerce/domain/usecases/payment/fetch_payment.dart';

FetchPayment makeFetchPayment() => RemoteFetchPayment(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('payment'),
    );
