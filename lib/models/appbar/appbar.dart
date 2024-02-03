import 'package:flutter/material.dart';

class NavigationAppBar extends StatelessWidget {
  const NavigationAppBar({super.key});

  @override
  Widget build(BuildContext context) {
// 화면 시작
    return AppBar(
// 앱 바 메인 텍스트
        title: const Text('sample'),
        leading: IconButton(
          icon: const Icon(Icons.home),
          tooltip: 'home',
          onPressed: () {
            // 홈으로 이동
          },
        ),
// 첫 번째 아이콘 버튼 배치되어 있음.
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.notifications),
              tooltip: 'alert', // icon 설명 tooltip
              onPressed: () {
// 클릭 이벤트 추가 필요
              }),
// 프로필
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'profile',
            onPressed: () {
// nativator 사용, return Scaffold가 반환하는 값을 user 페이지로 한다. (import로 조정하면 될듯)
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                      // 요기 profile 페이지를 추가한다.
                      );
                },
              ));
            },
          ),
        ],
      );
  }
}
