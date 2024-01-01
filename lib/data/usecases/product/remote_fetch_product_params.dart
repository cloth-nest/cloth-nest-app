// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerce/app/utils/extensions/double_extension.dart';
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
  if (priceRange == 'Below ${10.0.toMoney()}') {
    return 'LT10';
  } else if (priceRange == '${10.0.toMoney()} - ${20.0.toMoney()}') {
    return 'GTE10_LT20';
  } else if (priceRange == '${20.0.toMoney()} - ${30.0.toMoney()}') {
    return 'GTE20_LT30';
  } else if (priceRange == '${30.0.toMoney()} - ${50.0.toMoney()}') {
    return 'GTE30_LT50';
  } else if (priceRange == 'Above ${50.0.toMoney()}') {
    return 'GTE50';
  }
  return 'ALL';
}
