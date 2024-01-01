import 'package:ecommerce/presentation/screens/checkout/checkout_screen.dart';
import 'package:ecommerce/presentation/screens/checkout/successful_checkout_screen.dart';

CheckOutScreen makeCheckOutView(int? variantId) => CheckOutScreen(
      variantId: variantId,
    );
SuccessfulCheckOutScreen makeSuccessCheckOutView() =>
    const SuccessfulCheckOutScreen();
