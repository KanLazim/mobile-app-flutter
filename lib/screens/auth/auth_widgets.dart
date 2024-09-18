// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kan_lazim/core/colors.dart';
import 'package:kan_lazim/core/extensions.dart';
import 'package:kan_lazim/screens/auth/register.dart';

Align authTitle(BuildContext context, String title) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
      title,
      style: context.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
    ),
  );
}

Row _authDivider() {
  return const Row(
    children: [Expanded(child: Divider()), Expanded(child: Divider())],
  );
}

class AuthWithGoogle extends StatelessWidget {
  const AuthWithGoogle({
    super.key,
    required this.isRegisterPage,
  });
  final bool isRegisterPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        _authDivider(),
        const SizedBox(height: 20),
        isRegisterPage ? _loginButton(context) : _createAccount(context)
      ],
    );
  }

  TextButton _loginButton(BuildContext context) => TextButton.icon(
      icon: const Icon(Icons.login),
      onPressed: () {
        Navigator.pop(context);
      },
      label: const Text("Giriş Yap"));

  Row _createAccount(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Hesabın yok mu?"),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Register()));
              },
              child: const Text("Kayıt Ol", style: TextStyle(color: ColorsConstant.redFrame)))
        ],
      );
}
