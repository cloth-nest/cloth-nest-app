import 'dart:io';

import 'package:ecommerce/app/factories/usecases/create_review/create_review_factory.dart';
import 'package:ecommerce/presentation/presenters/review/review_order_state.dart';
import 'package:ecommerce/presentation/screens/review/review_order_presenter.dart';
import 'package:flutter/material.dart';

class ProviderReviewOrderPresenter
    with ChangeNotifier
    implements ReviewOrderPresenter {
  ReviewOrderState _state;

  ProviderReviewOrderPresenter({
    required ReviewOrderState state,
  }) : _state = state;

  @override
  List<File> get images => _state.images;

  @override
  bool get isLoading => _state.isLoading;

  @override
  double get rating => _state.rating;

  @override
  void setImages({required List<File> images}) {
    _state = _state.copyWith(images: [..._state.images, ...images]);
    notifyListeners();
  }

  @override
  void setRate({required double rate}) {
    if (_state.rating != rate) {
      _state = _state.copyWith(rating: rate);
      notifyListeners();
    }
  }

  @override
  void removeAtIndex({required int index}) {
    List<File> currentImages = [...images];

    currentImages.removeAt(index);

    _state = _state.copyWith(images: currentImages);
    notifyListeners();
  }

  @override
  void review({required int idProduct}) async {
    try {
      _state = _state.copyWith(isLoading: true);
      notifyListeners();

      await makeFetchCreateReview().call(
        idProduct: idProduct,
        reviewContent: reviewContent,
        rating: rating,
        files: images,
      );

      _state = _state.copyWith(isLoading: false, errorMessage: 'success');
      notifyListeners();
    } catch (e) {
      _state = _state.copyWith(isLoading: false);
      notifyListeners();
      debugPrint('##error review: $e');
    } finally {}
  }

  @override
  String get reviewContent => _state.review;

  @override
  void setReviewContent({required String review}) {
    _state = _state.copyWith(review: review);
    notifyListeners();
  }

  @override
  // TODO: implement errorMessage
  String? get errorMessage => _state.errorMessage;
}
