import 'package:flutter/material.dart';

// LoginPage 클래스 예시
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // 입력 폼
          Form(
            // 색상
            child: Theme(
              data: ThemeData(
                // 메인 컬러
                primaryColor: Colors.grey,
                inputDecorationTheme: InputDecorationTheme(
                  // input color, font-size css
                  labelStyle: TextStyle(color: Colors.teal, fontSize: 15.0),
                ),
              ),
              // 내부 컨테이너
              child: Container(
                // 패딩
                padding: EdgeInsets.fromLTRB(30, 30, 30, 0),	// 각각 (left, top, right, bottom)
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'email',
                          hintText: 'email',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'password',
                          labelText: 'password',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                      ),
                      // text field 간 간격
                      SizedBox(height: 50.0),
                      ButtonTheme(
                        minWidth: 100.0,
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () {
                            // 버튼 클릭 이벤트 처리
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                          ),
                          child: Text(
                            "로그인", // 버튼 내부에 들어갈 텍스트
                            style: TextStyle(
                              fontSize: 18, // 텍스트 크기 설정
                              color: Colors.white, // 텍스트 색상 설정
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
