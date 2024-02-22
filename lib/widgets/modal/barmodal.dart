import 'package:flutter/material.dart';
import 'package:inglo/screens/detail_sketch/detail_sketch4.dart';
import 'package:inglo/screens/profile/widgets/detailsketch.dart';
import 'package:inglo/widgets/comment/comment_box.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:google_fonts/google_fonts.dart';

class BarModal extends StatelessWidget {
  final int id;
  final int sketch_id;

  const BarModal({Key? key, required this.id, required this.sketch_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 오른쪽 정렬
        children: [
          Container(
            width: 150,
            height: 40,
            color: Colors.transparent,
            child: FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailSketch4Page(sketchId: sketch_id), // 또는 sketchId: _selectedIndex, 를 전달
                  ),
                );
              },
              child: Text(
                'See Sketch',
                style: GoogleFonts.notoSans(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: Color(0xFFD7A859),
                minimumSize: Size(50, 40),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () => showBarModalBottomSheet(
              expand: false,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => Comments(id: id),
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // 중앙 정렬
                      children: [
                        Text('Feedbacks',
                            style: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                        Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 20,
                        ),
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
