import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:inglo/screens/signin/signin.dart';
import 'package:inglo/screens/signup/get_profile.dart';
import 'package:inglo/widgets/dropdown/borderdropdownbutton.dart';
import 'package:inglo/util/options/country_data.dart';
import 'package:inglo/util/options/language_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

// LoginPage 클래스
class _AccountPageState extends State<AccountPage> {
  String _name = ''; // 사용자 이름 저장을 위한 변수
  String _country = 'country1'; // 국가 저장을 위한 변수
  String _language = 'en'; // 언어 저장을 위한 변수

  // 유저 정보 전송 api
  Future<void> _handlePost() async {
    final url = "https://dongkyeom.com/api/v1/accounts/info/";
    Map<String, String> data = {
      "name": _name,
      "country": _country,
      "language": _language,
    };

    Map<String, String> headers = {
      "Content-Type": 'application/json',
      "Authorization": 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA4MzUzOTc5LCJpYXQiOjE3MDgzNTAzNzksImp0aSI6Ijg4YjM5ZTE3Y2RlMzRmY2FhZjZmZjI1NTRiMjVlNDdkIiwidXNlcl9pZCI6M30.Wjxayhs_Zk_locENQ9Yyzz4G1yh4_z7uQBkIVYwGeVI',
    };

    try {
      final http.Response response = await http.patch(
        Uri.parse(url), // URL 파싱
        headers: headers,
        body: json.encode(data), // 데이터 JSON 인코딩
      );

      if (response.statusCode == 200) {
        // 성공
        print('Success code: ${response.statusCode}, response: ${response.body}');
      } else {
        // 비-200 상태 코드
        print('Error code: ${response.statusCode}, response: ${response.body}');
      }
    } catch (e) {
      // 예외 처리
      print('Exception caught: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // 배경 이미지를 넣기 위해 Scaffold를 Container로 감싸준다.
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill, // 배경이미지 fit 하게 하기
        repeat: ImageRepeat.noRepeat,
        image: Svg(
          'assets/image/background/background_2.svg',
          // size: Size(10, 10), // size 지정 하던 안 하던 동일하다.
        ),
      )),
      child: Scaffold(
        resizeToAvoidBottomInset: false, // 스크롤이 scaffold 영역을 건드리지 않는다.
        // 배경 이미지를 위해 Scaffold의 배경색을 투명으로 한다.
        // backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: <Widget>[
    SingleChildScrollView(
          child: Padding(
            // 전체 padding
            padding: const EdgeInsets.fromLTRB(40, 80, 40, 0),
            child: Theme(
              data: ThemeData(
                primaryColor: Color(0xFFFFD691),
                inputDecorationTheme: InputDecorationTheme(
                  labelStyle:
                  GoogleFonts.notoSans(
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
                  focusedBorder: OutlineInputBorder( // 포커스를 받았을 때의 테두리 스타일
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
                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10,)
                      ),
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
                    child: BorderCustomDropdown(options: countryData),),
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
                      child: BorderCustomDropdown(options: languageData),),
                    SizedBox(height: 100.0),
                    // Login Button
                    FilledButton(
                      onPressed: _handlePost,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFFFFD691)), // 버튼 배경색
                        minimumSize: MaterialStateProperty.all(Size(400, 40)), // 버튼 사이즈
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
    ]
        ),
      ),
    );
  }
}
