import 'package:flutter/material.dart';
import 'package:inglo/screens/start/start.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //  debugShowCheckedModeBanner: false, //오른쪽 상단에 배너 띠를 없애준다.
      home: StartPage(), // 화면의 표시될 스크린
    );
  }
}
