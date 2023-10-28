import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/configs/i18n/app_languages.dart';
import 'package:ecommerce/presentation/screens/account/account_presenter.dart';
import 'package:ecommerce/presentation/widgets/button/b_round_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late AccountPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = context.read<AccountPresenter>();
    _presenter.addListener(_onListener);
  }

  void _onListener() {
    if (_presenter.navigateTo != null) {
      Beamer.of(context, root: true).beamToReplacementNamed('/login');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _presenter.removeListener(_onListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (context.locale == AppLanguages.viLocale) {
                        context.setLocale(AppLanguages.enLocale);
                      } else {
                        context.setLocale(AppLanguages.viLocale);
                      }
                    },
                    child: const Text('Change Language'),
                  ),
                ),
                BRoundButton(
                  minimumSize: const Size(200, 45),
                  maximumSize: const Size(200, 45),
                  buttonName: 'Test Logout',
                  onClick: () {
                    _presenter.logout();
                  },
                ),
                const SizedBox(height: 20),
                BRoundButton(
                  minimumSize: const Size(300, 45),
                  maximumSize: const Size(300, 45),
                  buttonName: 'Test auto login',
                  onClick: () {
                    _presenter.testAutoLogin();
                  },
                ),
              ],
            ),
          ),
          Selector<AccountPresenter, bool>(
            selector: (context, presenter) => presenter.isLoading,
            builder: (context, isLoading, _) {
              if (isLoading) {
                return Container(
                  color: Colors.grey.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
