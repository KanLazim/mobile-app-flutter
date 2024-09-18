// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kan_lazim/core/colors.dart';
import 'package:kan_lazim/core/extensions.dart';
import 'package:kan_lazim/core/padding_borders.dart';
import 'package:kan_lazim/core/useful_functions.dart';
import 'package:kan_lazim/models/user_model.dart';
import 'package:kan_lazim/screens/home/bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.mdoel,
  });
  final UserModel mdoel;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsConstant.appbar,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 50,
            ),
            const SizedBox(width: 10),
            const Text(
              'Kan Lazım',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: context.deviceWidth * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: ColorsConstant.location,
                          size: 40,
                        ),
                        Text(
                          widget.mdoel.city ?? "İstanbul",
                          style: const TextStyle(
                              fontSize: 20, color: ColorsConstant.locationadres, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: PaddingBorderConstant.borderRadiusMedium,
                  child: Image.asset(
                    'assets/images/home.webp',
                  ),
                ),
                Container(
                  margin: PaddingBorderConstant.paddingVerticalHigh,
                  height: context.deviceHeight * 0.25,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavBar(
                                    userModel: widget.mdoel,
                                    pageIndex: 1,
                                  )));
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/location.jpg',
                            width: context.deviceWidth * 0.15,
                          ),
                          const Text(
                            "Yakındaki Bağışçılar",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: context.deviceHeight * 0.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            await browser("https://kanbankasi.gen.tr/kan-bagis-noktalari/");
                          },
                          child: Card(
                            elevation: 5,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/images/kanbagisi.jpg',
                                  alignment: Alignment.center,
                                ),
                                const Text(
                                  'Kan Bankası',
                                  style: TextStyle(
                                      fontSize: 20, color: ColorsConstant.locationadres, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            await browser("https://www.google.com/search?q=en+yakın+hastane+${widget.mdoel.city ?? ""}");
                          },
                          child: Card(
                            elevation: 5,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/images/hospital.jpg',
                                ),
                                const Text(
                                  'Hastane',
                                  style: TextStyle(
                                      fontSize: 20, color: ColorsConstant.locationadres, fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
