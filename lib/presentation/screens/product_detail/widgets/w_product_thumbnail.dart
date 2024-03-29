import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/app/resources/app_colors.dart';
import 'package:ecommerce/domain/entities/detail_product/image_entity.dart';
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
    final themeColor = Theme.of(context);

    return Selector<ProductDetailPresenter, List<ImageEntity>>(
        selector: (_, presenter) => presenter.images,
        builder: (_, images, __) => images.isEmpty
            ? const SizedBox.shrink()
            : AspectRatio(
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
                                _presenter.setActivePage(value % images.length);
                                _animationController.reset();
                                _animationController.forward();
                              },
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    color: AppColors.white,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          images[index % images.length].image,
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
                                child: _customLoadingIndicator(images.length),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ));
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
