import 'package:ecommerce/app/factories/http/api_url_factory.dart';
import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/cart/remote_fetch_add_to_cart.dart';
import 'package:ecommerce/data/usecases/cart/remote_fetch_cart.dart';
import 'package:ecommerce/data/usecases/cart/remote_fetch_remove_from_cart.dart';
import 'package:ecommerce/domain/usecases/cart/fetch_add_to_cart.dart';
import 'package:ecommerce/domain/usecases/cart/fetch_cart.dart';
import 'package:ecommerce/domain/usecases/cart/fetch_remove_from_cart.dart';

FetchCart makeFetchCart() => RemoteFetchCart(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('cart'),
    );

FetchAddToCart makeFetchAddToCart() => RemoteFetchAddToCart(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('cart'),
    );

FetchRemoveFromCart makeFetchRemoveFromCart() => RemoteFetchRemoveFromCart(
      client: makeHttpAuthorizedAdapter(),
      url: makeApiUrl('cart'),
    );
