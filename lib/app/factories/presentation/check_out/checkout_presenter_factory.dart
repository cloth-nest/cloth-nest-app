import 'package:ecommerce/app/factories/usecases/bill/fetch_calculate_bill_factory.dart';
import 'package:ecommerce/app/factories/usecases/fetch_address/fetch_address_factory.dart';
import 'package:ecommerce/app/factories/usecases/checkout/checkout_factory.dart';
import 'package:ecommerce/app/factories/usecases/payment/fetch_payment.dart';
import 'package:ecommerce/app/factories/usecases/service_type/service_type_factory.dart';
import 'package:ecommerce/presentation/presenters/checkout/checkout_out_state.dart';
import 'package:ecommerce/presentation/presenters/checkout/provider_checkout_presenter.dart';
import 'package:ecommerce/presentation/screens/checkout/checkout_presenter.dart';

CheckOutPresenter makeCheckOutPresenter() => ProviderCheckOutPresenter(
      state: CheckOutState.initial(),
      fetchCalculateBill: makeFetchCalculateBill(),
      fetchAddress: makeFetchAddress(),
      fetchOrder: makeFetchCheckOut(),
      fetchPayment: makeFetchPayment(),
      fetchServiceType: makeFetchServiceType(),
    );
