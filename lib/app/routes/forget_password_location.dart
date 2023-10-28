import 'package:beamer/beamer.dart';
import 'package:ecommerce/app/factories/presentation/forget_password/forget_password_presenter_factory.dart';
import 'package:ecommerce/app/factories/presentation/forget_password/forget_password_view_factory.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ForgetPasswordLocation extends BeamLocation<BeamState> {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      BeamPage(
        key: const ValueKey('forget_password'),
        title: 'forget_password',
        child: ChangeNotifierProvider(
          create: (_) => makeForgetPasswordPresenter(),
          child: makeForgetPasswordView(),
        ),
      ),
    ];
  }

  @override
  List<Pattern> get pathPatterns => ['/forget_password'];
}
