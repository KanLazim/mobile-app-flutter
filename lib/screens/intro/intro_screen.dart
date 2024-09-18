import 'package:flutter/material.dart';
import 'package:kan_lazim/core/colors.dart';
import 'package:kan_lazim/core/custom_button.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: TextButton.icon(
              iconAlignment: IconAlignment.end,
              onPressed: () {},
              label: const Text(
                'İleri',
                style: TextStyle(fontSize: 16, color: ColorsConstant.skipt),
              ),
              icon: const Icon(
                Icons.arrow_right_alt_rounded,
              ),
            ),
          ),
          Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover,
          ),
          CustomMainButton(
            onPressed: () {},
            text: "Giriş Yap",
            buttonWidth: 0.8,
            isOutline: true,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomMainButton(
            onPressed: () {},
            text: "Kayıt Ol",
            buttonWidth: 0.8,
          ),
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            'assets/images/dalga.png',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
