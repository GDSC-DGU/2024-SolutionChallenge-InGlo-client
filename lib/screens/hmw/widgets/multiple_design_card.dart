import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/screens/hmw/hmw_detail.dart';

class MultipleDesignCard extends StatelessWidget {
  final String content;
  const MultipleDesignCard({
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HMWDetailPage(),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            //width: 150,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                  color: Color(0xFF233A66),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                  offset: Offset(9, 9),
                ),
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                  offset: Offset(6, 6),
                ),
                BoxShadow(
                  color: Color(0xFF233A66),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                  offset: Offset(3, 3),
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
            left: -15,
            child: Image(
              width: 200,
              image: Svg('assets/image/design/card_spring.svg'),
            ),
          )
        ],
      ),
    );
  }
}
