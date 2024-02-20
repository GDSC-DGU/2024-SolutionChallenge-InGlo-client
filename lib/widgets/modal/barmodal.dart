import 'package:flutter/material.dart';
import 'package:inglo/widgets/comment/comment_box.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:google_fonts/google_fonts.dart';

class BarModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end, // 오른쪽 정렬
        children: [
          Container(
            width: 150,
            height: 40,
            child: FilledButton(
              onPressed: () {},
              child: Text(
                'See Sketch',
                style: GoogleFonts.notoSans(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: Color(0xFFD7A859),
                minimumSize: Size(50, 40),
              ),
            ),
          ),
          SizedBox(height: 10,),
          InkWell(
              onTap: () => showBarModalBottomSheet(
                expand: false,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => Comments(),
              ),
              child: Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFF233A66),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 중앙 정렬
                        children: [
                          Text('Feedbacks', style: GoogleFonts.notoSans(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700)),
                          Icon(Icons.send, color: Colors.white, size: 20,),
                        ],
                      ),
                    ),
                  ),
                ),

              ),
          ),
        ],
      ),
    );
  }
}