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
                padding: EdgeInsets.all(40.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(labelText: 'Enter email'),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Enter password'),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                      ),
                      SizedBox(height: 40.0),
                      ButtonTheme(
                        minWidth: 100.0,
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () {
                            // 버튼 클릭 이벤트 처리
                          },
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 35.0,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
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