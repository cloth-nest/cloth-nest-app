import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/app/configs/i18n/app_languages.dart';
import 'package:flutter/material.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return const AccountScreen();
  }
}

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (context.locale == AppLanguages.viLocale) {
                  context.setLocale(AppLanguages.enLocale);
                } else {
                  context.setLocale(AppLanguages.viLocale);
                }
              },
              child: const Text('Change Language'),
            ),
          ),
        ],
      ),
    );
  }
}
