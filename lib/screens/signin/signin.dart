import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

// LoginPage 클래스 예시
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using Scaffold as the base widget for the page layout.
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
        // Utilizing SingleChildScrollView to ensure the page is scrollable when the keyboard appears.
        body: SingleChildScrollView(
          child: Padding(
            // Consistent padding around the form for better layout.
            padding: const EdgeInsets.all(30.0),
            child: Form(
              child: Theme(
                // Custom Theme data for the form elements.
                data: ThemeData(
                  primaryColor: Colors.teal, // Adjusting primaryColor to match the overall theme.
                  inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.teal, fontSize: 15.0),
                  ),
                ),
                child: Column(
                  children: [
                    // Email TextField
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20.0),
                    // Password TextField
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true, // Ensures text is obscured for password entry.
                    ),
                    SizedBox(height: 50.0),
                    // Login Button
                    ElevatedButton(
                      onPressed: () {
                        // Placeholder for login logic.
                        print('Login button pressed'); // Example action to replace with actual login logic.
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orangeAccent, // Button background color.
                        minimumSize: Size(100, 50), // Button size.
                      ),
                      child: Text(
                        "로그인",
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
