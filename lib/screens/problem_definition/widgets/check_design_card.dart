import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckDesignCard extends StatelessWidget {
  final String content;
  final bool isChecked = true;
  //final changeisChecked;
  const CheckDesignCard({
    required this.content,
    //required this.isChecked,
    //required this.changeisChecked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          //width: 150,
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 3,
              color: isChecked ? Color(0xFFFF6280) : Color(0xFFD7A859),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFFFD691),
                blurRadius: 0.0,
                spreadRadius: 0.0,
                offset: Offset(6, 6),
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
        ),
        Positioned(
          top: -2,
          right: -20,
          child: RawMaterialButton(
            onPressed: () {
              // check값 바꾸기
            },
            elevation: 0,
            fillColor: Colors.white,
            child: isChecked ? Icon(
              Icons.check_rounded,
              size: 25.0,
              color: Color(0xFFFF6280),
            ) : Text(""),
            padding: EdgeInsets.all(0.0),
            shape: CircleBorder(
              side: BorderSide(
                width: 3,
                color: isChecked ? Color(0xFFFF6280) : Color(0xFFD7A859),
              ),
            ),
          ),
          // child: ElevatedButton(
          //   onPressed: () {},
          //   style: ElevatedButton.styleFrom(
          //     alignment: Alignment.centerLeft,
          //     backgroundColor: Colors.white,
          //     shape: CircleBorder(),
          //     // padding도 넣을 수 있음!
          //     side: BorderSide(
          //       width: 3,
          //       color: isChecked ? Color(0xFFFF6280) : Color(0xFFD7A859),
          //     ),
          //     fixedSize: Size(30, 30),
          //   ),
          //   child: isChecked ? Icon(Icons.abc, color: Color(0xFFFF6280), size: 30,) : Text(""),
          // ),
        ),
      ],
    );
  }
}
