import 'package:flutter/material.dart';
import 'package:inglo/screens/home/home.dart';
import 'package:inglo/screens/post/create_post.dart';
import 'package:inglo/screens/postlist/post_board.dart';
import 'package:inglo/screens/signup/signup.dart';
import 'package:inglo/screens/start/start.dart';
import 'screens/signin/signin.dart';
import 'package:inglo/screens/issuelist/issulist.dart';
import 'models/appbar/appbar.dart';
import 'package:flutter/material.dart';
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
      home: MainScreen(), // 화면의 표시될 스크린
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // 현재 선택된 탭의 인덱스

  // 각 탭에 해당하는 페이지 위젯
  final List<Widget> _pages = [
    IssueListPage(),
    StartPage(),
    PostBoardPage(),
    MessagesPage(),
    // MessagesPage(),
    // 참고 페이지(나중에 삭제)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
        onItemTapped: _onItemTapped, // 함수 전송),
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Notifications Page'),
    );
  }
}

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Messages Page'),
    );
  }
}
