import 'package:flutter/material.dart';
import 'package:inglo/widgets/comment/comment_box.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:google_fonts/google_fonts.dart';

class BarModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.end, // 오른쪽 정렬
        children: [
          InkWell(
              onTap: () => showBarModalBottomSheet(
                expand: false,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => Comments(),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
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
                          Text('Feedbacks', style: GoogleFonts.notoSans(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700)),
                          Icon(Icons.send, color: Colors.white,),
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