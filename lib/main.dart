import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inglo/provider/post/post_sdgs.dart';
import 'package:inglo/provider/user_token/user_token.dart';
import 'package:inglo/screens/issuelist/issulist.dart';
import 'package:inglo/screens/start/start.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/provider/test/counts.dart';
import 'package:inglo/service/auth/google/google_sign.dart';
import 'package:provider/provider.dart';

// user
import 'package:inglo/provider/profile/users.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  // 여러 상태를 사용하기 위해, multi provider를 사용한다.
  runApp(
    MultiProvider(
      providers: [
        // 아마 아래에 상태 변수들을 계속 추가하면 될 것 같다.
        ChangeNotifierProvider(create: (_) => Counts()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => UserToken()),
        ChangeNotifierProvider(create: (_) => PostSDGS()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartPage(),
      theme: ThemeData(
        // ThemeData를 사용하여 앱의 기본 테마를 설정합니다.
        textTheme: GoogleFonts.notoSansTextTheme(
          // 기본 폰트 적용
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
