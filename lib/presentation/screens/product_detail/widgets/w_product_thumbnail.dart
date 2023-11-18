import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/presentation/screens/product_detail/product_detail_presenter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WProductThumbNail extends StatefulWidget {
  const WProductThumbNail({super.key});

  @override
  State<WProductThumbNail> createState() => _WProductThumbNailState();
}

class _WProductThumbNailState extends State<WProductThumbNail>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late final ProductDetailPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = context.read<ProductDetailPresenter>();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.forward();

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setAutoSlide();
      }
    });
  }

  Future<void> setAutoSlide() async {
    _animationController.reset();

    _presenter.pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );

    await _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imageUrls = [
      'https://bizweb.dktcdn.net/100/369/010/products/2-c7489656-f1cb-4b10-ac93-a6af49cd3617.jpg?v=1698056890097',
      'https://bizweb.dktcdn.net/100/369/010/products/1-d78cb512-6469-4bb7-9c85-1385ec64b833.jpg?v=1698056890097',
      'https://bizweb.dktcdn.net/100/369/010/products/1-2e90e381-0e8d-4b00-b266-91c065eb2123.jpg?v=1697719183130',
      'https://bizweb.dktcdn.net/100/369/010/products/artboard-1-copy-2-aed65ebb-0e0c-434b-b477-50eecf3acca2.jpg?v=1697719183130',
      'https://bizweb.dktcdn.net/100/369/010/products/artboard-1-copy-552d3a63-656a-492c-be16-2091b2ae9cd6.jpg?v=1697719181600',
      'https://bizweb.dktcdn.net/100/369/010/products/artboard-1-96438371-b209-4454-97b5-e694a4829002.jpg?v=1697719181600',
    ];
    final themeColor = Theme.of(context);

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: LayoutBuilder(
        builder: (_, constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Listener(
                  onPointerDown: (event) {
                    _animationController.stop();
                  },
                  onPointerUp: (_) {
                    _animationController.forward();
                  },
                  child: PageView.builder(
                    allowImplicitScrolling: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: _presenter.pageController,
                    onPageChanged: (value) {
                      _presenter.setActivePage(value % imageUrls.length);
                      _animationController.reset();
                      _animationController.forward();
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: AppColors.white,
                          child: CachedNetworkImage(
                            imageUrl: imageUrls[index % imageUrls.length],
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 13,
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: themeColor.scaffoldBackgroundColor,
                    ),
                    child: Center(
                      child: _customLoadingIndicator(imageUrls.length),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _customLoadingIndicator(int length) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          length,
          (index) {
            return Selector<ProductDetailPresenter, int>(
              selector: (_, presenter) => presenter.activePage,
              builder: (_, activePage, __) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: index != activePage
                    ? Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.iconDisabled,
                        ),
                      )
                    : SizedBox(
                        width: 30,
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: LinearProgressIndicator(
                                value: _animation.value,
                                backgroundColor: AppColors.iconDisabled,
                              ),
                            );
                          },
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
