import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:inglo/screens/issuelist/issulist.dart';
import 'package:google_fonts/google_fonts.dart';

// LoginPage 클래스
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // 배경 이미지를 넣기 위해 Scaffold를 Container로 감싸준다.
      decoration: BoxDecoration(
          image: DecorationImage(
        fit: BoxFit.fill,
        repeat: ImageRepeat.noRepeat,
        image: Svg(
          'assets/image/background/background.svg',
          // size: Size(10, 10), // size 지정 하던 안 하던 동일하다.
        ),
      )),
      child: Scaffold(
        // 배경 이미지를 위해 Scaffold의 배경색을 투명으로 한다.
        backgroundColor: Colors.white,
        // 수직 스크롤이 된다고 한다.
        // 나중에 빼도 될 것 같다!
        body: SingleChildScrollView(
          child: Padding(
            // 전체 padding
            padding: const EdgeInsets.fromLTRB(40, 160, 40, 0),
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
                        "SIGNIN",
                        style: GoogleFonts.notoSans(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    // label에 padding 추가
                    // lable에 animation을 넣고 싶다면 labeltext를 추가하자.
                    Padding(
                      padding: const EdgeInsets.fromLTRB(11, 0, 0, 5),
                      child: Text("email",
                          style: GoogleFonts.notoSans(
                            color: Colors.black,
                          )),
                    ),
                    // Email TextField
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'email',
                        isDense: true, // textformfield를 타이트하게 만든다.
                        contentPadding: EdgeInsets.all(10), // padding
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.notoSans(fontSize: 14), // textsize 조정
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 0, 0, 3),
                      child: Text("password",
                          style: GoogleFonts.notoSans(
                            color: Colors.black,
                          )),
                    ),
                    // passowrd textfield
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'password',
                        isDense: true,
                        contentPadding: EdgeInsets.all(10), // padding
                      ),
                      obscureText: true, // 비밀번호와 같은 민감한 정보용
                      style: GoogleFonts.notoSans(fontSize: 14),
                    ),
                    SizedBox(height: 80.0),
                    // Login Button
                    FilledButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => IssueListPage()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color(0xFFFFD691)), // 버튼 배경색
                        minimumSize:
                            MaterialStateProperty.all(Size(400, 40)), // 버튼 사이즈
                      ),
                      child: Text(
                        "SIGNIN",
                        style: GoogleFonts.notoSans(
                            fontSize: 18,
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
      ),
    );
  }
}
