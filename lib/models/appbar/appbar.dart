// custom_navigation_bar.dart
import 'package:flutter/material.dart';

class NavigationAppBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  NavigationAppBar({required this.currentIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    // 아래 네비게이션 바
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'issue',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'home',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle),
            label: 'board',
          ),
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'my',
          ),
        ],
        height: 80.0, // height
        selectedIndex: currentIndex, // 선택 index
        onDestinationSelected: onItemTapped, // tab event
      ),
    );
  }
}