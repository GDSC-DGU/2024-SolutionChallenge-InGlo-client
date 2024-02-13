import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:inglo/widgets/dropdown/borderdropdownbutton.dart';
import 'package:inglo/util/options/country_data.dart';
import 'package:inglo/util/options/language_data.dart';

// LoginPage 클래스
class AccountPage extends StatelessWidget {
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
        backgroundColor: Colors.transparent,
        // 수직 스크롤이 된다고 한다.
        // 나중에 빼도 될 것 같다!
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
                      TextStyle(color: Color(0xFFFFD691), fontSize: 47.0),
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
                        "ACCOUNT",
                        style: TextStyle(
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
                      child: Text("name",
                          style: TextStyle(
                            color: Colors.black,
                          )),
                    ),
                    // Email TextField
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'name',
                        isDense: true,
                        contentPadding: EdgeInsets.all(8), // padding
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 0, 0, 3),
                      child: Text("email",
                          style: TextStyle(
                            color: Colors.black,
                          )),
                    ),
                    // passowrd textfield
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'email',
                        isDense: true,
                        contentPadding: EdgeInsets.all(10), // padding
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 0, 0, 3),
                      child: Text("password",
                          style: TextStyle(
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
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 0, 0, 3),
                      child: Text("country",
                          style: TextStyle(
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(
                        height: 45.0,
                    child: BorderCustomDropdown(options: countryData),),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(7, 0, 0, 3),
                      child: Text("language",
                          style: TextStyle(
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(
                      height: 45.0,
                      child: BorderCustomDropdown(options: languageData),),
                    SizedBox(height: 40.0),
                    // Login Button
                    ElevatedButton(
                      onPressed: () {
                        // Placeholder for login logic.
                        print('Login button pressed');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFD691), // Button 배경색
                        minimumSize: Size(400, 40), // Button 사이즈
                      ),
                      child: Text(
                        "SIGNUP",
                        style: TextStyle(
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
    ]
        ),
      ),
    );
  }
}
