import 'package:flutter/material.dart';
import 'package:mental_health_app/age.dart';
import 'package:mental_health_app/anxiety.dart';
import 'package:mental_health_app/bantuan.dart';
import 'package:mental_health_app/bipolar.dart';
import 'package:mental_health_app/depresi.dart';
import 'package:mental_health_app/detection.dart';
import 'package:mental_health_app/detection2.dart';
import 'package:mental_health_app/detection3.dart';
import 'package:mental_health_app/detection4.dart';
import 'package:mental_health_app/disclaimer.dart';
import 'package:mental_health_app/edeitprofil.dart';
import 'package:mental_health_app/gender.dart';
import 'package:mental_health_app/home.dart';
import 'package:mental_health_app/hubungikami.dart';
import 'package:mental_health_app/identitas.dart';
import 'package:mental_health_app/login.dart';
import 'package:mental_health_app/lupapasword.dart';
import 'package:mental_health_app/name.dart';
import 'package:mental_health_app/page1.dart';
import 'package:mental_health_app/page10.dart';
import 'package:mental_health_app/page11.dart';
import 'package:mental_health_app/page12.dart';
import 'package:mental_health_app/page13.dart';
import 'package:mental_health_app/page14.dart';
import 'package:mental_health_app/page15.dart';
import 'package:mental_health_app/page16.dart';
import 'package:mental_health_app/page17.dart';
import 'package:mental_health_app/page2.dart';
import 'package:mental_health_app/page3.dart';
import 'package:mental_health_app/page4.dart';
import 'package:mental_health_app/page5.dart';
import 'package:mental_health_app/page6.dart';
import 'package:mental_health_app/page7.dart';
import 'package:mental_health_app/page8.dart';
import 'package:mental_health_app/page9.dart';
import 'package:mental_health_app/privasi.dart';
import 'package:mental_health_app/profil.dart';
import 'package:mental_health_app/result.dart';
import 'package:mental_health_app/riwayatdeteksi.dart';
import 'package:mental_health_app/setting.dart';
import 'package:mental_health_app/sign.dart';
import 'package:mental_health_app/splashscreen.dart';
import 'package:mental_health_app/tentangkami.dart';
import 'package:mental_health_app/welcome.dart';

Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  MHealthHomePage.routeName: (context) => const MHealthHomePage(),
  DisclaimerPage.routeName: (context) => const DisclaimerPage(),
  LoginPage.routeName: (context) => const LoginPage(), 
  SignUpPage.routeName: (context) => const SignUpPage(),
  IdentitasPage.routeName: (context) => const IdentitasPage(),
  NamePage.routeName: (context) => const NamePage(),
  GenderSelectionScreen.routeName: (context) => const GenderSelectionScreen(),
  AgeSelection.routeName: (context) => const AgeSelection(),
  HomePage.routeName: (context) => const HomePage(),
  Tahap1Page.routeName:(context) => const Tahap1Page(),
  PertanyaanPage.routeName:(context) => const PertanyaanPage(),
  PertanyaanPage2.routeName: (context) => const PertanyaanPage2(),
  PertanyaanPage3.routeName: (context) => const PertanyaanPage3(),
  PertanyaanPage4.routeName: (context) => const PertanyaanPage4(),
  PertanyaanPage5.routeName: (context) => const PertanyaanPage5(),
  Tahap2Page.routeName:(context) => const Tahap2Page(),
  PertanyaanPage6.routeName: (context) => const PertanyaanPage6(),
  PertanyaanPage7.routeName: (context) => const PertanyaanPage7(),
  PertanyaanPage8.routeName: (context) => const PertanyaanPage8(),
  Tahap3Page.routeName:(context) => const Tahap3Page(),
  PertanyaanPage9.routeName: (context) => const PertanyaanPage9(),
  PertanyaanPage10.routeName: (context) => const PertanyaanPage10(),
  PertanyaanPage11.routeName: (context) => const PertanyaanPage11(),
  PertanyaanPage12.routeName: (context) => const PertanyaanPage12(),
  PertanyaanPage13.routeName: (context) => const PertanyaanPage13(),
  Tahap4Page.routeName:(context) => const Tahap4Page(),
  PertanyaanPage14.routeName: (context) => const PertanyaanPage14(),
  PertanyaanPage15.routeName: (context) => const PertanyaanPage15(),
  PertanyaanPage16.routeName: (context) => const PertanyaanPage16(),
  PertanyaanPage17.routeName: (context) => const PertanyaanPage17(),
  PrivacyScreens.routeName:(context) => const PrivacyScreens(),
  HubungiKami.routeName: (context) => const HubungiKami(),
  FAQScreen.routeName: (context) => const FAQScreen(),
  TentangKamiScreen.routeName:(context) => const TentangKamiScreen(),
  SettingsScreen.routeName:(context) => const SettingsScreen(),
  EditProfileScreen.routeName:(context) => const EditProfileScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  RiwayatDeteksi.routeName:(context) => const RiwayatDeteksi(),
  DetectionResultScreen.routeName:(context) => const DetectionResultScreen(),
  DetectionResultScreen2.routeName:(context) => const DetectionResultScreen2(),
  DetectionResultScreen3.routeName:(context) => const DetectionResultScreen3(),
  HasilDeteksi.routeName:(context) => const HasilDeteksi(),
  LupaPasswordScreen.routeName: (context) =>  LupaPasswordScreen(),
  //MainPage.routeName:(context) => const MainPage(),
};
