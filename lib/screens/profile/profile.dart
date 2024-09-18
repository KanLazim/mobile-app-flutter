// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kan_lazim/core/colors.dart';
import 'package:kan_lazim/core/custom_button.dart';
import 'package:kan_lazim/core/extensions.dart';
import 'package:kan_lazim/core/padding_borders.dart';
import 'package:kan_lazim/models/user_model.dart';
import 'package:kan_lazim/screens/auth/login.dart';
import 'package:kan_lazim/screens/my_reguest/my_request.dart';
import 'package:kan_lazim/services/firebase_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    required this.model,
  });
  final UserModel model;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: ContextExtension(context).deviceWidth,
                height: ContextExtension(context).deviceHeight * 0.2,
                color: ColorsConstant.profile,
              ),
              Positioned(
                top: ContextExtension(context).deviceHeight * 0.1,
                left: ContextExtension(context).deviceWidth * 0.35,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 8,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: PaddingBorderConstant.paddingOnlyTopHigh,
            child: Text(
              widget.model.name ?? "",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(
            color: Colors.black,
            indent: 20,
            endIndent: 20,
          ),
          SizedBox(
            width: ContextExtension(context).deviceWidth * 0.9,
            height: ContextExtension(context).deviceHeight * 0.2,
            child: Card(
                shadowColor: ColorsConstant.redFrame,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Profilewidget(
                        icon: Icons.location_on, text: 'İl/İlçe:', text2: '${widget.model.city}/ ${widget.model.district}'),
                    Profilewidget(icon: Icons.email, text: 'Email:', text2: widget.model.email ?? ""),
                    Profilewidget(
                        icon: Icons.water_drop_rounded,
                        text: "Kan Grubu",
                        text2: widget.model.bloodType ?? "Kan Grubu Girilmedi"),
                  ],
                )),
          ),
          const SizedBox(height: 10),
          CustomMainButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyRequest()));
            },
            text: "Taleplerim",
            buttonWidth: 0.9,
            isOutline: true,
          ),
          CustomMainButton(
            onPressed: () async {
              await FirebaseService().logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
            },
            text: "Çıkış Yap",
            buttonWidth: 0.9,
            isOutline: false,
          ),
        ],
      ),
    );
  }
}

class Profilewidget extends StatelessWidget {
  const Profilewidget({
    super.key,
    required this.icon,
    required this.text,
    required this.text2,
  });

  final IconData icon;
  final String text;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8), // İkon ile metin arasına boşluk ekledik
            Text(text),
          ],
        ),
        Expanded(
          // Text2'yi sağa doğru genişletiyoruz
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              text2,
              textAlign: TextAlign.right, // Sağa hizalıyoruz
            ),
          ),
        ),
      ],
    );
  }
}
