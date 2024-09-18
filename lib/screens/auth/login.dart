import 'package:flutter/material.dart';
import 'package:kan_lazim/core/colors.dart';
import 'package:kan_lazim/core/custom_button.dart';
import 'package:kan_lazim/core/custom_textfield.dart';
import 'package:kan_lazim/core/extensions.dart';
import 'package:kan_lazim/screens/auth/auth_widgets.dart';
import 'package:kan_lazim/screens/auth/register.dart';
import 'package:kan_lazim/screens/home/bottom_bar.dart';
import 'package:kan_lazim/services/firebase_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: context.deviceWidth * 0.9,
            child: Form(
              key: _globalKey,
              child: Column(
                children: [
                  const SizedBox(height: 90),
                  authTitle(context, "Hoşgeldin!"),
                  const SizedBox(height: 50),
                  CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      return isValidEmail(value);
                    },
                    controller: _emailController,
                    labelText: "E-posta adresi",
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Şifre boş olamaz";
                      } else if ((value?.length ?? 0) < 6) {
                        return "Şifre 6 karakterden az olamaz";
                      }
                      return null;
                    },
                    controller: _passwordController,
                    labelText: "Şifre",
                    isPassword: true,
                  ),
                  // Align(
                  //     alignment: Alignment.centerRight,
                  //     child: TextButton(
                  //         onPressed: () {},
                  //         child: Text(
                  //           "Şifremi unuttum?",
                  //           style: context.textTheme.titleSmall?.copyWith(color: ColorsConstant.redFrame),
                  //         ))),
                  const SizedBox(height: 50),
                  CustomMainButton(
                      onPressed: () async {
                        if (_globalKey.currentState?.validate() ?? false) {
                          final login = await FirebaseService().login(email: _emailController.text.trim(), password: _passwordController.text.trim());

                          if (login) {
                            final getModel = await FirebaseService().getUser();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavBar(userModel: getModel)));
                          } else {
                            const snackBar = SnackBar(backgroundColor: ColorsConstant.red, content: Center(child: Text("Şifre veya e-posta yanlış")));

                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        }
                      },
                      text: "Giriş Yap",
                      buttonWidth: 0.75),
                  const SizedBox(height: 20),
                  const AuthWithGoogle(isRegisterPage: false)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
