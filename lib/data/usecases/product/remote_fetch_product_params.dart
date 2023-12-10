// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/domain/usecases/product/fetch_product_params.dart';
import 'package:equatable/equatable.dart';

class RemoteFetchProductParams extends Equatable {
  final int page;
  final int limit;
  final String? orderDirection;
  final String? colorIdList;
  final String? sizeIdList;
  final String? priceRange;
  final int idCategory;

  const RemoteFetchProductParams({
    required this.page,
    required this.limit,
    this.orderDirection,
    this.colorIdList,
    this.sizeIdList,
    this.priceRange,
    required this.idCategory,
  });

  @override
  List<Object?> get props => [
        page,
        limit,
        idCategory,
      ];

  factory RemoteFetchProductParams.fromDomain(FetchProductParams params) =>
      RemoteFetchProductParams(
        limit: params.limit,
        page: params.page,
        idCategory: params.idCategory,
        colorIdList: toIdList(values: params.colors),
        sizeIdList: toIdList(
          values: params.sizes,
        ),
        orderDirection:
            toOrderDirection(direction: params.orderDirection ?? ''),
        priceRange: toPriceRange(priceRange: params.priceRange ?? ''),
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'limit': limit,
      'page': page,
      'orderDirection': orderDirection,
      'colorIdList': colorIdList,
      'sizeIdList': sizeIdList,
      'priceRange': priceRange,
    };

    json.removeWhere((key, value) => value == null || value == '');

    return json;
  }
}

String? toIdList({required List<String> values}) {
  if (values.isEmpty) {
    return null;
  }

  String idList = '';

  for (var value in values) {
    if (value == values.last) {
      idList += value;
      break;
    }
    idList += '$value,';
  }

  return idList;
}

String? toOrderDirection({required String direction}) {
  switch (direction) {
    case 'Created descending':
      return 'LATEST';
    case 'Price ascending':
      return 'PRICE_ASC';
    case 'Price descending':
      return 'PRICE_DESC';
    default:
  }
  return null;
}

String? toPriceRange({required String priceRange}) {
  switch (priceRange) {
    case 'Below 100.000đ':
      return 'LT10';
    case '100.000đ - 200.000đ':
      return 'GTE10_LT20';
    case '200.000đ - 300.000đ':
      return 'GTE20_LT30';
    case '300.000đ - 500.000đ':
      return 'GTE30_LT50';
    case 'Above 500.000đ':
      return 'GTE50';
    default:
  }
  return 'ALL';
}
