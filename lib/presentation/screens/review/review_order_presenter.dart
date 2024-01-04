import 'dart:io';

import 'package:flutter/material.dart';

abstract class ReviewOrderPresenter implements ChangeNotifier {
  bool get isLoading;
  double get rating;
  List<File> get images;
  String get reviewContent;
  String? get errorMessage;

  void setRate({required double rate});
  void setImages({required List<File> images});
  void removeAtIndex({required int index});
  void review({required int idProduct});
  void setReviewContent({required String review});
}
