import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/models/profile/user.dart';
import 'package:inglo/provider/profile/users.dart';
import 'package:inglo/screens/profile/widgets/mydrawing.dart';
import 'package:inglo/screens/profile/widgets/myposts.dart';
import 'package:inglo/screens/profile/widgets/setting.dart';
import 'package:inglo/service/profile/profile.dart';
import 'package:inglo/util/profile/user_preferences.dart';
import 'package:inglo/widgets/appbar/appbar.dart';
import 'package:inglo/widgets/modal/alert_modal.dart';
import 'package:inglo/widgets/profile/numbers_widget.dart';
import 'package:inglo/widgets/profile/percent.dart';
import 'package:inglo/widgets/profile/profile_widget.dart';
import 'package:inglo/widgets/profile/button_widget.dart';
import 'package:dio/dio.dart';

// provider
import 'package:provider/provider.dart';
import 'package:inglo/provider/user_token/user_token.dart';

import 'dart:convert';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final dio = Dio(); // dio instance 생성
  // User? _user;
  String? token = ''; // token 빈 값으로 우선 정의

  final ProfileService _authService = ProfileService();

  // 초기 1번 실행
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      token = Provider.of<UserToken>(context, listen: false)
          .token; // provider에서 토큰 가져오기
      // await를 사용하여 프로필을 가져오고 상태 업데이트
      await _authService.getProfile(token, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        User? _user = userProvider.user;
        return Scaffold(
          body: Container(
            color: Color(0xFFF7EEDE),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.only(
                    left: 30.0,
                    top: 0,
                    right: 30.0,
                    bottom: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NumbersWidget(user: _user ?? UserPreferences.myUser),
                      Column(
                        children: [
                          ProfileWidget(
                            imagePath: _user?.profile_img ?? '',
                            global_impact: _user?.global_impact ?? 0.0,
                          ),
                        ],
                      ),
                      PercentWidget(user: _user ?? UserPreferences.myUser),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                buildName(_user ?? UserPreferences.myUser),
                const SizedBox(height: 20),
                buildAbout(_user ?? UserPreferences.myUser),
              ],
            ),
          ),
          bottomNavigationBar: NavigationAppBar(
            currentIndex: 3, // index 전송
          ),
        );
      },
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user?.name ?? 'Unknown',
            style:
                GoogleFonts.notoSans(fontWeight: FontWeight.w500, fontSize: 24),
          ),
        ],
      );

  Widget buildAbout(User user) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                color: Colors.white, // 상자 색
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    ButtonWidget(
                      text: 'My Sketchs',
                      color: 'D55382',
                      bg: 'EDD2DB',
                      icon1: Icons.draw,
                      icon2: Icons.arrow_forward_ios,
                      onPressed: () {
                        // My Sketchs 버튼이 눌렸을 때 처리할 내용
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyDrawing(),
                          ),
                        );
                      },
                    ),
                    ButtonWidget(
                      text: 'My Posts',
                      color: '8584DF',
                      bg: 'D4D6F5',
                      icon1: Icons.signpost,
                      icon2: Icons.arrow_forward_ios,
                      onPressed: () => showPreparingModal(context),
                    ),
                    ButtonWidget(
                      text: 'Language',
                      color: '000000',
                      bg: 'C4C4C4',
                      icon1: Icons.language_outlined,
                      icon2: Icons.arrow_forward_ios,
                      onPressed: () {
                        // My Sketchs 버튼이 눌렸을 때 처리할 내용
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SetProfilePage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
