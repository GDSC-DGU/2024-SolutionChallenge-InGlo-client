import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatefulWidget {
  final String text;
  final String color;
  final String bg;
  final IconData icon1;
  final IconData icon2;
  final VoidCallback onPressed; // onPressed 속성 추가

  const ButtonWidget({
    required this.text,
    required this.color,
    required this.bg,
    required this.icon1,
    required this.icon2,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector( // GestureDetector를 사용하여 버튼 클릭을 감지
      onTap: widget.onPressed, // onPressed 콜백을 연결
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(int.parse("0xFF${widget.bg}"),),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Icon(widget.icon1, color: Color(int.parse("0xFF${widget.color}"),), size: 30,),
                    ),
                    SizedBox(width: 20,),
                    Text(widget.text,
                        style: GoogleFonts.notoSans(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
                Icon(widget.icon2, size: 24,),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}