import 'package:ecommerce/app/utils/utils.dart';
import 'package:ecommerce/domain/entities/product/product_entity.dart';
import 'package:ecommerce/presentation/screens/qr_code/qr_code_presenter.dart';
import 'package:ecommerce/presentation/screens/qr_code/widgets/horizontal_list_products.dart';
import 'package:ecommerce/presentation/screens/qr_code/widgets/horizontal_list_products_loading.dart';
import 'package:ecommerce/presentation/widgets/w_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key});

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  MobileScannerController cameraController =
      MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);
  late QrCodePresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = context.read<QrCodePresenter>();
    cameraController.stop();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      presenter.initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: const WAppBar(
        title: 'Scan',
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Column(
            children: [
              SizedBox(
                height: size.height * .35,
                child: MobileScanner(
                  controller: cameraController,
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    for (final barcode in barcodes) {
                      final String? idProduct = barcode.rawValue;
                      presenter.saveProduct(
                          idProduct: int.parse(idProduct ?? '0'));
                      beamTo(context, path: 'product?idProduct=$idProduct');
                      break;
                    }
                  },
                  errorBuilder: (_, e, __) {
                    return Text('$e');
                  },
                ),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Scan History',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                              ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            presenter.deleteAll();
                          },
                          child: const Icon(Icons.delete_outline_outlined),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Selector<QrCodePresenter, bool>(
                    selector: (_, presenter) => presenter.isLoading,
                    builder: (_, isLoading, __) => isLoading
                        ? const HorizontalListProductsLoading()
                        : Selector<QrCodePresenter, List<ProductEntity>>(
                            selector: (_, presenter) => presenter.products,
                            builder: (_, products, __) => products.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(
                                      'Scanned products will be listed here',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  )
                                : HorizontalListProducts(products: products),
                          ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
