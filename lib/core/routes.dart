// import 'package:flutter/material.dart';
// import 'package:kan_lazim/core/app_routes_name.dart';
// import 'package:kan_lazim/screens/home/bottom_bar.dart';
// import 'package:kan_lazim/screens/intro/intro_screen.dart';

// class AppRoutes {
//   //bu kısımda sayfaların yönlendirme işlemleri yapılır
//   static Route onGenerateRoutes(RouteSettings settings) {
//     switch (settings.name) {
//       case '/': //burda şunu yapıyoruz eğer bir sayfa yoksa anasayfaya yönlendiriyoruz
//         return _materialRoute(const IntroScreen()); //burda anasayfaya yönlendirme işlemi yapılıyor

//       case AppRouteNames.login: //burda şu işlemi yapıyoruz eğer login sayfası varsa login sayfasına yönlendiriyoruz
//         return _materialRoute(const BottomNavBar());

//       default: //burda şunu yapıyoruz eğer bir sayfa yoksa anasayfaya yönlendiriyoruz
//         return _materialRoute(const IntroScreen());
//     }
//   }

// //burda sayfaların yönlendirme işlemleri yapılıyor
//   static Route<dynamic> _materialRoute(Widget view) {
//     return MaterialPageRoute(builder: (_) => view);
//   }
// }
