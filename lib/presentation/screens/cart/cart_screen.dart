import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/app/utils/utils.dart';
import 'package:ecommerce/domain/entities/cart/cart_entity.dart';
import 'package:ecommerce/presentation/screens/cart/cart_presenter.dart';
import 'package:ecommerce/presentation/screens/cart/widgets/cart_sliver_list.dart';
import 'package:ecommerce/presentation/screens/cart/widgets/cart_sliver_list_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = context.read<CartPresenter>();
    _presenter.addListener(_onListener);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _presenter.initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(
            fontSize: 17,
            color: AppColors.textLightBasic,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0.3,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(32),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                bottom: 10,
              ),
              child: Selector<CartPresenter, List<CartEntity>>(
                selector: (_, presenter) => presenter.carts,
                builder: (_, carts, __) => Text(
                  '${carts.length} Item(s)',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _presenter.refreshData,
        child: Selector<CartPresenter, bool>(
          selector: (_, presenter) => presenter.isLoading,
          builder: (_, isLoading, __) => CustomScrollView(
            clipBehavior: Clip.none,
            shrinkWrap: true,
            physics: isLoading
                ? const NeverScrollableScrollPhysics()
                : const AlwaysScrollableScrollPhysics(),
            slivers: [
              isLoading ? const CartSliverListLoading() : const CartSliverList()
            ],
          ),
        ),
      ),
    );
  }

  void _onListener() {
    if (_presenter.isAvailable != null) {
      if (_presenter.isAvailable == false) {
        showCustomDialog(
            context, 'Checkout Failed', 'Products are not available');
      } else {
        beamTo(context, path: 'check_out');
        FocusScope.of(context).requestFocus(FocusNode());
      }
    }
  }
}
