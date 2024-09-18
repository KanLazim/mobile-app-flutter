import 'package:flutter/material.dart';
import 'package:kan_lazim/core/colors.dart';
import 'package:kan_lazim/core/custom_button.dart';
import 'package:kan_lazim/core/custom_textfield.dart';
import 'package:kan_lazim/core/extensions.dart';
import 'package:kan_lazim/core/padding_borders.dart';
import 'package:kan_lazim/models/user_model.dart';
import 'package:kan_lazim/screens/auth/auth_widgets.dart';
import 'package:kan_lazim/screens/global_widgets.dart';
import 'package:kan_lazim/screens/home/bottom_bar.dart';
import 'package:kan_lazim/services/firebase_service.dart';

String? isValidEmail(String? email) {
  // E-posta için RegEx deseni
  String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  RegExp regex = RegExp(pattern);

  if (email != null && !regex.hasMatch(email)) {
    return "Doğru email adresi giriniz";
  } else {
    return null;
  }
}

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late final TextEditingController _emailController;
  late final TextEditingController _nameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _rePasswordController;
  final GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  void initState() {
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
    _rePasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  String? _selectedCity;
  String? _selectedDistrict;

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
                  authTitle(context, "Hesap Oluştur!"),
                  const SizedBox(height: 15),
                  Card(
                    child: Container(
                      padding: PaddingBorderConstant.paddingAllHigh,
                      child: Column(
                        children: [
                          CustomTextField(
                            keyboardType: TextInputType.emailAddress,
                            labelText: "E-posta",
                            controller: _emailController,
                            validator: (value) {
                              return isValidEmail(value);
                            },
                          ),
                          const SizedBox(height: 15),
                          CustomTextField(
                            labelText: "İsim",
                            controller: _nameController,
                            validator: (value) {
                              if ((value?.length ?? 0) > 25) {
                                return "İsim 25 karakteri geçemez";
                              } else if (value?.isEmpty ?? true) {
                                return "Lütfen isim giriniz";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          _selectCityAndDistrict(
                            title: "İl seçiniz ${_selectedCity != null ? '($_selectedCity)' : ""}",
                            selectedCityOrDistrict: (selectedItem) {
                              setState(() {
                                _selectedCity = selectedItem;
                              });
                            },
                          ),
                          const SizedBox(height: 15),
                          _selectCityAndDistrict(
                            city: _selectedCity,
                            title: "İlçe seçiniz ${_selectedDistrict != null ? '($_selectedDistrict)' : ""}",
                            selectedCityOrDistrict: (selectedItem) {
                              setState(() {
                                _selectedDistrict = selectedItem;
                              });
                            },
                          ),
                          const SizedBox(height: 15),
                          CustomTextField(
                            controller: _passwordController,
                            labelText: "Şifre",
                            isPassword: true,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return "Şifre boş olamaz";
                              } else if ((value?.length ?? 0) < 6) {
                                return "Şifre 6 karakterden az olmamalıdır";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          CustomTextField(
                            controller: _rePasswordController,
                            labelText: "Şifreyi onayla",
                            isPassword: true,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return "Şifre boş olamaz";
                              } else if (_passwordController.text.trim() != value?.trim()) {
                                return "Şifreler eşleşmiyor!";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  CustomMainButton(
                      onPressed: () async {
                        if (_globalKey.currentState?.validate() ?? false) {
                          if (_selectedCity != null && _selectedDistrict != null) {
                            final userModel = UserModel(
                                city: _selectedCity,
                                district: _selectedDistrict,
                                email: _emailController.text.trim(),
                                name: _nameController.text.trim());
                            final create = await FirebaseService().createUser(model: userModel, password: _passwordController.text.trim());
                            if (create) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBar(userModel: userModel)));
                            } else {
                              const snackBar = SnackBar(backgroundColor: ColorsConstant.red, content: Center(child: Text("Birşeyler ters gitti")));

                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          } else {
                            const snackBar =
                                SnackBar(backgroundColor: ColorsConstant.red, content: Center(child: Text("Lütfen bir İl ve ilçe seçin")));

                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        }
                      },
                      text: "Kayıt Ol",
                      buttonWidth: 0.75),
                  const AuthWithGoogle(isRegisterPage: true)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectCityAndDistrict({required String title, required Function(String selectedItem) selectedCityOrDistrict, String? city}) {
    final bool isCity = title.toLowerCase().contains("ilçe") == false;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => SearchCityAndState(
            isSearchCity: isCity,
            city: isCity ? null : city,
            selectedCity: (selectedCity) => selectedCityOrDistrict.call(selectedCity ?? ""),
            selectedDistrict: (selectedDistrict) => selectedCityOrDistrict.call(selectedDistrict ?? ""),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: PaddingBorderConstant.paddingAll,
        decoration: BoxDecoration(
          borderRadius: PaddingBorderConstant.borderRadius,
          border: Border.all(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            const Icon(Icons.arrow_drop_down_outlined),
          ],
        ),
      ),
    );
  }
}
