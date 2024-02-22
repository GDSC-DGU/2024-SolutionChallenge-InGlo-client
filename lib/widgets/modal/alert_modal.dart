import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YourClassName extends StatelessWidget {
  const YourClassName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

void showPreparingModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xFFFFD691),
        title: Text('Preparing', style: GoogleFonts.notoSans(fontSize: 26, fontWeight: FontWeight.w600, color: Colors.white),),
        content: Text('It will be released soon.', style: GoogleFonts.notoSans(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop(); // 다이얼로그 닫기
            },
          ),
        ],
      );
    },
  );
}
