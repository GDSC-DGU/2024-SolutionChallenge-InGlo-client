import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

// LoginPage 클래스 예시
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // 배경 이미지를 넣기 위해 Scaffold를 Container로 감싸준다.
      decoration: BoxDecoration(
        image: DecorationImage(
          repeat: ImageRepeat.noRepeat,
          image: Svg(
            'assets/image/background/background.svg',
            // size: Size(10, 10), // size 지정 하던 안 하던 동일하다.
          ),
        )
      ),
      child: Scaffold(
        // 배경 이미지를 위해 Scaffold의 배경색을 투명으로 한다.
        backgroundColor: Colors.transparent,
        // 수직 스크롤이 된다고 한다.
        // 나중에 빼도 될 것 같다!
        body: SingleChildScrollView(
          child: Padding(
            // 전체 padding
            padding: const EdgeInsets.fromLTRB(80, 220, 80, 0),
            child: Form(
              child: Theme(
                data: ThemeData(
                  primaryColor: Color(0xFFFFD691),
                  inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(color: Color(0xFFFFD691), fontSize: 15.0),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "SIGNIN",
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                    SizedBox(height: 40.0),
                    // Email TextField
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)
                        ),
                        contentPadding: EdgeInsets.all(8), // padding
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 35.0),
                    // Password TextField
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)
                        ),
                        contentPadding: EdgeInsets.all(8), // padding
                      ),
                      obscureText: true, // 경고 표시 OX
                    ),
                    SizedBox(height: 120.0),
                    // Login Button
                    ElevatedButton(
                      onPressed: () {
                        // Placeholder for login logic.
                        print('Login button pressed');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFD691), // Button 배경색
                        minimumSize: Size(400, 50), // Button 사이즈
                      ),
                      child: Text(
                        "SIGNIN",
                        style: TextStyle(fontSize: 18, color: Colors.white),
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
