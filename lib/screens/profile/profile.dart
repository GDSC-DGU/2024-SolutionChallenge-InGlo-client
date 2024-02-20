import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/models/profile/user.dart';
import 'package:inglo/screens/profile/widgets/mydrawing.dart';
import 'package:inglo/screens/profile/widgets/myposts.dart';
import 'package:inglo/screens/profile/widgets/setting.dart';
import 'package:inglo/util/profile/user_preferences.dart';
import 'package:inglo/widgets/appbar/appbar.dart';
import 'package:inglo/widgets/profile/numbers_widget.dart';
import 'package:inglo/widgets/profile/percent.dart';
import 'package:inglo/widgets/profile/profile_widget.dart';
import 'package:inglo/widgets/profile/button_widget.dart';
import 'package:dio/dio.dart';
// provider
import 'package:provider/provider.dart';
import 'package:inglo/provider/profile/users.dart';

import 'dart:convert';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final dio = Dio(); // dio instance 생성
  User? _user = UserPreferences.myUser;

  // 임시 변수
  /*
  int _id = 0;
  String _email = '';
  String _name = '';
  String _profile_img = '';
  int _country = 0;
  String _language = '';
  int _liked_total = 0;
  int _sketch_num = 0;
  int _feedback_total = 0;
  int _post_total = 0;
  double _global_impact = 0;
*/

  // 초기 1번 실행
  void initState() {
    super.initState();
    getProfile();
  }

  // 전체 update 함수
  void updateSpecificUserInfo(BuildContext context, User newUser) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    userProvider.updateUser(newUser);
  }

  // profile get 함수
  Future<void> getProfile() async {
    final url = "https://dongkyeom.com/api/v1/accounts/info/";

    try {
      final response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA4NTc3MDgwLCJpYXQiOjE3MDg0MzMwODAsImp0aSI6IjU1YWYyZjg2Y2I2NzQxOTFiMWQ5OWI0MjNhZmMxODEyIiwidXNlcl9pZCI6M30.ws5KsW_fBY-Kun1u3Rexkvnyjwz6_uN0PBqTnw7BKYs',
          },
        ),
      );

      String responseBody = response.data;

      User user = parseUser(responseBody); // 받아온 데이터를 User 객체로 생성

      setState(() {
        _user = user; // _user 변수에 값을 할당하고 화면을 다시 그림
      });

      print('user : $user');

      // 굳이 필요 없을 것 같기도..
      updateSpecificUserInfo(context, user); // 전체 업데이트

    } catch (e) {
      // 요청 실패 또는 기타 에러 처리
      print('Error fetching data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {

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
                  NumbersWidget(user: _user!),
                  Column(
                    children: [
                      ProfileWidget(
                        imagePath: _user!.profile_img,
                      ),
                    ],
                  ),
                  PercentWidget(user: _user!),
                ],
              ),
            ),
            const SizedBox(height: 24),
            buildName(_user!),
            const SizedBox(height: 20),
            buildAbout(_user!),
          ],
        ),
      ),
      bottomNavigationBar: NavigationAppBar(
        currentIndex: 3, // index 전송
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            _user!.name,
            style: GoogleFonts.notoSans(fontWeight: FontWeight.w500, fontSize: 24),
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
                      onPressed: () {
                        // My Sketchs 버튼이 눌렸을 때 처리할 내용
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyPosting(),
                          ),
                        );
                      },
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
                            builder: (context) => Setting(),
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
