import 'package:ecommerce/presentation/screens/login/login_presenter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = context.read<LoginPresenter>();
    _presenter.addListener(_onListener);
  }

  void _onListener() {}

  @override
  void dispose() {
    super.dispose();
    _presenter.removeListener(_onListener);
    _presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoginScreen(
      presenter: _presenter,
    );
  }
}

class LoginScreen extends StatefulWidget {
  final LoginPresenter presenter;

  const LoginScreen({
    super.key,
    required this.presenter,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
