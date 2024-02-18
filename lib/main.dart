import 'package:flutter/material.dart';
import 'package:inglo/screens/start/start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/service/auth/google/google_sign.dart';
import 'package:inglo/widgets/card-slider/vertical_card_pager.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInDemo(), // 화면의 표시될 스크린
      theme: ThemeData(
        // ThemeData를 사용하여 앱의 기본 테마를 설정합니다.
        textTheme: GoogleFonts.notoSansTextTheme( // 기본 폰트 적용
          Theme.of(context).textTheme,
        ), // appbar bg
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false, // 오른쪽 상단의 배너 띠 엇애기
    );
  }
}
