import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:inglo/screens/issuelist/issulist.dart';
import 'package:inglo/screens/signup/get_profile.dart';
import 'package:inglo/widgets/dropdown/intdropdown.dart';
import 'package:inglo/widgets/dropdown/stringdropdown.dart';
import 'package:inglo/util/options/country_data.dart';
import 'package:inglo/util/options/language_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
// provider
import 'package:provider/provider.dart';
import 'package:inglo/provider/profile/users.dart';
import 'package:inglo/provider/user_token/user_token.dart';

import 'dart:convert';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

// LoginPage 클래스
class _AccountPageState extends State<AccountPage> {
  final dio = Dio(); // dio instance 생성

  String _name = ''; // 사용자 이름 저장을 위한 변수
  String _country = ''; // 국가 저장을 위한 변수
  String _language = ''; // 언어 저장을 위한 변수

  String? token; // token 저장

  // 초기 1번 실행
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print(Provider.of<UserToken>(context, listen: false).token);
      token = Provider.of<UserToken>(context, listen: false).token; // provider에서 토큰 가져오기
      await getAccountedUser(token); // 회원 정보가 있는 유저인지 확인한다.
    });
  }

  // is accounted user?
  Future<void> getAccountedUser(String? _token) async {
    print('회원정보 기입 페이지 token :  $_token');
    final url = "https://dongkyeom.com/api/v1/accounts/additional-info/";

    try {
      final response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            'Authorization': 'Bearer $_token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.data);
        print('true or false : ${responseBody['additional_info_provided']}');

        if (responseBody['additional_info_provided'] == true) {
          print("true");
          // 현재 화면을 새로운 화면으로 교체
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => IssueListPage()), // 다음 페이지로 이동
          );
        } else {
          print("false");
        }
      }

    } catch (e) {
      // 요청 실패 또는 기타 에러 처리
      print('Error fetching data: $e');
    }
  }


  // user name, langauge, country 업데이트 provider 함수
  void updateSpecificUserInfo(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // code 변경 함수
    userProvider.updateUserFields(
      name: _name,
      country: int.parse(_country),
      language: _language,
    );
  }

  // 유저 정보 전송 API
  Future<void> _handlePost() async {
    final url = "https://dongkyeom.com/api/v1/accounts/info/";
    Map<String, dynamic> data = {
      "name": _name,
      "country": int.parse('$_country'),
      "language": "en",
    };

    // 요청 헤더 설정
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {
        "Authorization":
            'Bearer $token',
      },
    );

    print('보내는 데이터 : $_name $_country $_language ');

    try {
      final response = await dio.patch(url, data: data, options: options);

      if (response.statusCode == 200) {
        // 성공
        print(
            'Success code: ${response.statusCode}, response: ${response.data}');
        updateSpecificUserInfo(context); // provider update

        // 현재 화면을 새로운 화면으로 교체
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GetProfilePage()), // 다음 페이지로 이동
        );

      } else {
        // 비-200 상태 코드
        print('Error code: ${response.statusCode}, response: ${response.data}');
      }
    } catch (e) {
      // 예외 처리
      print('Exception caught: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false, // 스크롤이 scaffold 영역을 건드리지 않는다.
        // 배경 이미지를 위해 Scaffold의 배경색을 투명으로 한다.
        // backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Stack(children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              // 전체 padding
              padding: const EdgeInsets.fromLTRB(40, 80, 40, 0),
              child: Theme(
                data: ThemeData(
                  primaryColor: Color(0xFFFFD691),
                  inputDecorationTheme: InputDecorationTheme(
                    labelStyle: GoogleFonts.notoSans(
                        color: Color(0xFFFFD691),
                        fontSize: 47.0,
                        fontWeight: FontWeight.w700),
                    // border 스타일
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Color(0xFFC4C4C4), // 테두리 색상
                        width: 1.0, // 테두리 두께
                      ),
                    ),
                    // 포커스 시 스타일
                    focusedBorder: OutlineInputBorder(
                      // 포커스를 받았을 때의 테두리 스타일
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Color(0xFFFFD691), // 포커스 받았을 때의 테두리 색상
                        width: 2.0, // 포커스 받았을 때의 테두리 두께
                      ),
                    ),
                  ),
                ),
                child: Form(
                  child: Column(
                    // crossAxis : 수평축을 따라 자식들을 어떻게 배치할 지
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxis : column 수직축을 따라 자식 위젯들을 어떻게 배치할 지
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // title만 중앙 정렬, 나머지는 flex-start
                      Center(
                        child: Text(
                          "INFORM",
                          style: GoogleFonts.notoSans(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
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
                      // Login Button
                      FilledButton(
                        onPressed: _handlePost,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color(0xFFFFD691)), // 버튼 배경색
                          minimumSize: MaterialStateProperty.all(
                              Size(400, 40)), // 버튼 사이즈
                        ),
                        child: Text(
                          "NEXT",
                          style: GoogleFonts.notoSans(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
