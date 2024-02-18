import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class WriteCard extends StatelessWidget {
  final id;
  final changeContent;
  const WriteCard({required this.id, required this.changeContent, super.key});

  @override
  Widget build(BuildContext context) {
    String value;
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                offset: Offset(8, 8),
              ),
            ],
          ),
          child: TextField(
            onChanged: (val) => changeContent(val),
            keyboardType: TextInputType.multiline, // 여러 줄
            maxLines: null, // 자동 줄 바꿈
            minLines: 10,
            style: GoogleFonts.cabinSketch(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 50,
          child: Container(
            width: MediaQuery.of(context).size.width - 95,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image(
                  width: 20,
                  image: Svg('assets/image/design/single_spring.svg'),
                ),
                Image(
                  width: 20,
                  image: Svg('assets/image/design/single_spring.svg'),
                ),
                Image(
                  width: 20,
                  image: Svg('assets/image/design/single_spring.svg'),
                ),
                Image(
                  width: 20,
                  image: Svg('assets/image/design/single_spring.svg'),
                ),
                Image(
                  width: 20,
                  image: Svg('assets/image/design/single_spring.svg'),
                ),
                Image(
                  width: 20,
                  image: Svg('assets/image/design/single_spring.svg'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
