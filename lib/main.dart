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
      home: MainScreen(), // 화면의 표시될 스크린
    );
  }
}

class MainScreen extends StatefulWidget {
  // screen 이동 상태 관리
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // 현재 선택된 탭의 인덱스


  final List<Widget> _pages = [
    // 각 탭에 해당하는 페이지 위젯 추가
    /**
     *
     * 여기에 페이지 추가하면서 확인하면 됨!!
     */
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // item을 클릭하면 해당 인덱스로 selectedIndex를 변경한다.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationAppBar(
        currentIndex: _selectedIndex, // index 전송
        onItemTapped: _onItemTapped, // 함수 전송
      ),
    );;
  }
}
