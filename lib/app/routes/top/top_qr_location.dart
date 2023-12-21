import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/qr_code/qr_code_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/qr_code/qr_code_view_factory.dart';
import 'package:ecommerce/app/routes/top/top_location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopQrLocation extends BeamLocation<BeamState> {
  TopQrLocation([super.routeInformation]);
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final topLocation = TopLocation();
    final pages = topLocation.buildPages(context, state);

    return pages
      ..add(
        BeamPage(
          key: const ValueKey('qr-code-screen'),
          child: ChangeNotifierProvider(
            create: (_) => makeQrCodePresenter(),
            child: makeQrCodeView(),
          ),
        ),
      );
  }

  @override
  List<Pattern> get pathPatterns => ['/qr_code'];
}
