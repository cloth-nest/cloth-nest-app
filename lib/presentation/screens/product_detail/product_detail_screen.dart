import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/resources/app_images.dart';
import 'package:ecommerce/app/utils/utils.dart';
import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_detail_product.dart';
import 'package:ecommerce/presentation/screens/product_detail/widgets/w_detail_product_loading.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final int idProduct;

  const ProductDetailScreen({
    super.key,
    required this.idProduct,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with WidgetsBindingObserver {
  late final ProductDetailPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = context.read<ProductDetailPresenter>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      presenter.initData(idProduct: widget.idProduct);
    });
    presenter.addListener(_onListener);
  }

  void _onListener() {
    if (presenter.successAddToCart != null) {
      showSnackBar(
        context,
        'Add to cart successfully',
        const Icon(
          Icons.check,
          color: Colors.white,
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    presenter.removeListener(_onListener);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(
            icon: SvgPicture.asset(
              SvgPaths.iconArrowLeft,
            ),
            onPressed: () {
              if (context.canPopBeamLocation) {
                context.popBeamLocation();
              }
            },
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
            height: size.height,
            child: Selector<ProductDetailPresenter, bool>(
              selector: (_, presenter) => presenter.isLoading,
              builder: (_, isLoading, __) => isLoading
                  ? const WDetailProductLoading()
                  : const WDetailProduct(),
            )),
      ),
    );
  }
}
