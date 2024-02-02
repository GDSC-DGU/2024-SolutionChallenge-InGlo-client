import 'package:flutter/material.dart';
import 'screens/signin/signin.dart';
import 'models/appbar/appbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //  debugShowCheckedModeBanner: false, //오른쪽 상단에 배너 띠를 없애준다.
      home: Scaffold(
          appBar: PreferredSize(
            // preferredSize를 지정해주지 않으면 에러가 발생한다.
            preferredSize: const Size.fromHeight(50),
            child: NavigationAppBar(),
          ),
          body: Center(
            child: LoginPage(),
          )),
    );
  }
}
