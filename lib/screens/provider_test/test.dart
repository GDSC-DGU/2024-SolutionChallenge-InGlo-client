import 'package:flutter/material.dart';
import 'package:inglo/screens/signup/get_profile.dart';
import 'package:inglo/screens/signup/signup.dart';
import 'package:provider/provider.dart';
import 'package:inglo/provider/test/counts.dart';
import 'package:inglo/widgets/provider_test/button.dart';
import 'package:inglo/widgets/provider_test/counter.dart';
import 'package:google_fonts/google_fonts.dart';

class ProviderTest extends StatefulWidget {
  const ProviderTest({super.key});

  @override
  State<ProviderTest> createState() => _ProviderTestState();
}

class _ProviderTestState extends State<ProviderTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider'),
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => Counts(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Counter(),
              Buttons(),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AccountPage()),
                  );
                },
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
    );
  }
}
