import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/review/remote_fetch_reviews.dart';
import 'package:ecommerce/domain/usecases/review/fetch_review.dart';

FetchReviews makeFetchReviews() => RemoteFetchReviews(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('review/product'),
    );
