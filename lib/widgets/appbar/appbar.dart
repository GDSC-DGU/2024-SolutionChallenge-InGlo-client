// custom_navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/screens/home/home.dart';
import 'package:inglo/screens/issuelist/issulist.dart';
import 'package:inglo/screens/postlist/post_board.dart';
import 'package:inglo/screens/profile/profile.dart';

class NavigationAppBar extends StatelessWidget {
  final int currentIndex;

  NavigationAppBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    // 아래 네비게이션 바
    return NavigationBar(
      destinations: [
        NavigationDestination(
          icon: getIconColor('assets/icon/navigation/news_icon.svg', 0),
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
      height: 60.0,
      selectedIndex: currentIndex,
      indicatorColor: Colors.transparent,
      backgroundColor: Colors.white,
      onDestinationSelected: (int index) {
        _navigateToPage(index, context);
      },
    );
  }


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

  // 이동 함수
  void _navigateToPage(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => IssueListPage()));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebViewMap()));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostBoardPage()));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePage()));
        break;
    }
  }
}
