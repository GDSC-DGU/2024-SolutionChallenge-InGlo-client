import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:inglo/screens/signin/signin.dart';
import 'package:inglo/screens/signup/signup.dart';
import 'package:google_fonts/google_fonts.dart';

// LoginPage 클래스
class StartPage extends StatelessWidget {
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
        backgroundColor: Colors.transparent,
        // 수직 스크롤이 된다고 한다.
        // 나중에 빼도 될 것 같다!
        body: SingleChildScrollView(
          child: Padding(
            // 전체 padding
            padding: const EdgeInsets.fromLTRB(60, 300, 60, 0),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 160.0),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => AccountPage()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white), // 버튼 배경색
                      minimumSize: MaterialStateProperty.all(Size(400, 40)), // 버튼 사이즈
                      // 테두리 색상 설정
                      side: MaterialStateProperty.all(BorderSide(color: Color(0xFFDADCE0), width: 1)),
                    ),
                    child: Text(
                      "SIGNIN WITH GOOGLE",
                      style: GoogleFonts.notoSans(
                          fontSize: 16,
                          color: Colors.black,),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
