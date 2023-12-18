import 'package:ecommerce/app/factories/http/http_client_factory.dart';
import 'package:ecommerce/data/usecases/place/remote_fetch_districts.dart';
import 'package:ecommerce/data/usecases/place/remote_fetch_provinces.dart';
import 'package:ecommerce/data/usecases/place/remote_fetch_wards.dart';
import 'package:ecommerce/domain/usecases/place/fetch_districts.dart';
import 'package:ecommerce/domain/usecases/place/fetch_provinces.dart';
import 'package:ecommerce/domain/usecases/place/fetch_wards.dart';

FetchProvinces makeFetchProvinces() => RemoteFetchProvinces(
      client: makeHttpAdapter(),
      url:
          'https://online-gateway.ghn.vn/shiip/public-api/master-data/province',
    );

FetchDistricts makeFetchDistricts() => RemoteFetchDistricts(
      client: makeHttpAdapter(),
      url:
          'https://online-gateway.ghn.vn/shiip/public-api/master-data/district',
    );

FetchWards makeFetchWards() => RemoteFetchWards(
      client: makeHttpAdapter(),
      url: 'https://online-gateway.ghn.vn/shiip/public-api/master-data/ward',
    );
