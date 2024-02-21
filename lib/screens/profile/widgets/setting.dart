import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/models/profile/user.dart';
import 'package:inglo/util/profile/user_preferences.dart';
import 'package:inglo/widgets/appbar/appbar.dart';
import 'package:inglo/widgets/profile/numbers_widget.dart';
import 'package:inglo/widgets/profile/percent.dart';
import 'package:inglo/widgets/profile/profile_widget.dart';
import 'package:dio/dio.dart';
import 'package:inglo/widgets/dropdown/intdropdown.dart';
import 'package:inglo/widgets/dropdown/stringdropdown.dart';
import 'package:inglo/util/options/country_data.dart';
import 'package:inglo/util/options/language_data.dart';

// provider
import 'package:provider/provider.dart';
import 'package:inglo/provider/profile/users.dart';
import 'package:inglo/provider/user_token/user_token.dart';

import 'dart:convert';

class SetProfilePage extends StatefulWidget {
  @override
  _SetProfilePageState createState() => _SetProfilePageState();
}

class _SetProfilePageState extends State<SetProfilePage> {
  final dio = Dio(); // dio instance 생성
  User? _user = UserPreferences.myUser;
  String? token = ''; // token 빈 값으로 우선 정의

  String _name = ''; // 사용자 이름 저장을 위한 변수
  int _country = 2; // 국가 저장을 위한 변수
  String _language = ''; // 언어 저장을 위한 변수

  // 초기 1번 실행
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      token = Provider.of<UserToken>(context, listen: false).token; // provider에서 토큰 가져오기
    });
  }

  // 전체 update 함수
  void updateSpecificUserInfo(BuildContext context, User newUser) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    userProvider.updateUser(newUser);
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
                        imagePath: _user?.profile_img ?? '',
                        global_impact: _user?.global_impact ?? 0.0,
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
            _user?.name ?? 'Unknown',
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
                  // crossAxis : 수평축을 따라 자식들을 어떻게 배치할 지
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxis : column 수직축을 따라 자식 위젯들을 어떻게 배치할 지
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 60.0),
                    // label에 padding 추가
                    // lable에 animation을 넣고 싶다면 labeltext를 추가하자.
                    Padding(
                      padding: const EdgeInsets.fromLTRB(11, 0, 0, 5),
                      child: Text("name",
                          style: GoogleFonts.notoSans(
                            color: Colors.black,
                          )),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'name',
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 10,
                          )),
                      style: GoogleFonts.notoSans(fontSize: 14),
                      onChanged: (value) {
                        setState(() {
                          _name = value; // 사용자 입력에 따라 _name 변수의 값을 변경
                        });
                      },
                    ),
                    SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 0, 0, 3),
                      child: Text("country",
                          style: GoogleFonts.notoSans(
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(
                      height: 45.0,
                      child: IntBorderCustomDropdown(
                        options: countryData,
                        onChanged: (value) {
                          setState(() {
                            if (value != null) {
                              _country = value; // _country는 널이 아닐 때만 업데이트
                            } else {
                              // 기본 국가 메서드
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 0, 0, 3),
                      child: Text("language",
                          style: GoogleFonts.notoSans(
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(
                      height: 45.0,
                      child: BorderCustomDropdown(
                        options: languageData,
                        onChanged: (value) {
                          setState(() {
                            if (value != null) {
                              _language = value; // _country는 널이 아닐 때만 업데이트
                            } else {
                              // 기본 언어 메서드
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 100.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
