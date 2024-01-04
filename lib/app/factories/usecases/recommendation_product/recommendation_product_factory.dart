import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/recommendation_product/remote_fetch_recommendation_product.dart';
import 'package:ecommerce/domain/usecases/recommendation_product/fetch_recommendation_product.dart';

FetchRecommendationProduct makeFetchRecommendationProduct() =>
    RemoteFetchRecommendationProduct(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('recommendation'),
    );
