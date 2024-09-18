import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kan_lazim/models/user_model.dart';
import 'package:kan_lazim/screens/auth/login.dart';
import 'package:kan_lazim/screens/home/bottom_bar.dart';
import 'package:kan_lazim/services/firebase_service.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double _opacity = 0.0;
  UserModel? _model;

  @override
  void initState() {
    super.initState();
    _startAnimationAndFetchData().whenComplete(
      () {
        if (_model != null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar(userModel: _model!)));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
        }
      },
    );
  }

  Future<void> _startAnimationAndFetchData() async {
    if (FirebaseService().userControll()) {
      _model = await FirebaseService().getUser();
    }

    await Future.delayed(const Duration(milliseconds: 150)); // Animasyonun başlangıcını bekliyoruz

    setState(() {
      _opacity = 1.0;
    });

    await Future.delayed(const Duration(seconds: 2)); // Animasyonun tamamlanmasını bekliyoruz
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 2),
              child: Image.asset('assets/images/logo.png'),
            ),
          ],
        ),
      ),
    );
  }
}
