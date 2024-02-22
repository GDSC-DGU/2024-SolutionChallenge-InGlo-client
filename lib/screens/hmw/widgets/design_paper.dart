import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/service/translate/translate_util.dart';

class DesignPaper extends StatelessWidget {
  final String content;
  const DesignPaper({required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TranslationService().getTranslation(content, context),
      builder: (context, snapshot) {
        var transData = snapshot.data!;
        return Container(
          width: 150,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
            color: Color(0xFFFFD691),
            border: Border.all(
              width: 1,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Text(
            transData,
            style: GoogleFonts.cabinSketch(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              // decoration: TextDecoration.underline, // 밑줄
              // decorationColor: Colors.grey, // 밑줄 색상
            ),
          ),
        );
      },
    );
  }
}
