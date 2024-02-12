import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class DesignCard extends StatelessWidget {
  final String content;
  const DesignCard({
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          //width: 150,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFFFD691),
                blurRadius: 0.0,
                spreadRadius: 0.0,
                offset: Offset(4, 4),
              ),
            ],
          ),
          child: Text(
            content,
            style: GoogleFonts.cabinSketch(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              // decoration: TextDecoration.underline, // 밑줄
              // decorationColor: Colors.grey, // 밑줄 색상
            ),
          ),
        ),
        Positioned(
          top: -5,
          left: -25,
          child: Image(
            width: 200,
            image: Svg('assets/image/design/card_spring.svg'),
          ),
        )
      ],
    );
  }
}
