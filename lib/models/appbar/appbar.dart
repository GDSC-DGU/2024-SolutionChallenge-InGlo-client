// custom_navigation_bar.dart
import 'package:flutter/material.dart';

class NavigationAppBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  NavigationAppBar({required this.currentIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // bottom navigation bar의 items로 index를 관리한다.
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
      currentIndex: currentIndex, // 선택된 index
      selectedItemColor: Colors.blue, // 선택 item color
      onTap: onItemTapped, // 콜백 함수
    );
  }
}