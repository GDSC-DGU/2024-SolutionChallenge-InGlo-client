// custom_navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavigationAppBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  NavigationAppBar({required this.currentIndex, required this.onItemTapped});

  // 선택 아이콘 색상 변경 함수
  Widget getIconColor(String assetName, int index) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        currentIndex == index ? Color(0xFFFF6E80) : Color(0xFF233A66),
        BlendMode.srcIn,
      ),
      child: SvgPicture.asset(assetName),
    );
  }

  @override
  Widget build(BuildContext context) {

    // 아래 네비게이션 바
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: getIconColor('assets/icon/navigation/news_icon.svg', 0), // 이미지 경로
            label: 'issue',
          ),
          NavigationDestination(
            icon: getIconColor('assets/icon/navigation/home_icon.svg', 1),
            label: 'home',
          ),
          NavigationDestination(
            icon: getIconColor('assets/icon/navigation/board_icon.svg', 2),
            label: 'board',
          ),
          NavigationDestination(
            icon: getIconColor('assets/icon/navigation/my_icon.svg', 3),
            label: 'my',
          ),
        ],
        height: 60.0, // height
        selectedIndex: currentIndex, // 선택 index
        onDestinationSelected: onItemTapped, // tab event
        indicatorColor: Colors.transparent, // 선택된 경우 버튼 색상(기본)
        backgroundColor: Colors.white, // 배경색
      ),
    );
  }
}
