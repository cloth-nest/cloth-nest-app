import 'package:ecommerce/presentation/presenters/review/provider_review_order_presenter.dart';
import 'package:ecommerce/presentation/presenters/review/review_order_state.dart';
import 'package:ecommerce/presentation/screens/review/review_order_presenter.dart';

ReviewOrderPresenter makeReviewOrderPresenter() => ProviderReviewOrderPresenter(
      state: ReviewOrderState.initial(),
    );
