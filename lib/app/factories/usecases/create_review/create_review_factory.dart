import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/create_review/remote_fetch_create_review.dart';
import 'package:ecommerce/domain/usecases/create_review/fetch_create_review.dart';

FetchCreateReview makeFetchCreateReview() => RemoteFetchCreateReview(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('review/product'),
    );
