import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgs/generated/l10n.dart';
import 'package:tgs/internal/router/app_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (context, ref, __) {
            final auth = ref.read(stateProvider.notifier);

            return TextButton(
              onPressed: () {
                auth.login();
              },
              child: const Text("Login"),
            );
          }
        ),
      ),
    );
  }
}
