import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/service/translate/translate_util.dart';

class CheckDesignPaper extends StatelessWidget {
  final id;
  final checkedId;
  final checkCard;
  final String content;
  const CheckDesignPaper({
    required this.id,
    required this.checkedId,
    required this.checkCard,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TranslationService().getTranslation(content, context),
      builder: (context, snapshot) {
        var transData = snapshot.data!;
        return Stack(
          children: [
            Container(
              constraints: BoxConstraints(
                minWidth: 160,
              ),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xFFFFD691),
                border: Border.all(
                  width: 3,
                  color:
                      id == checkedId ? Color(0xFFFF6280) : Color(0xFFD7A859),
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
            ),
            Positioned(
              top: -5,
              right: -20,
              child: RawMaterialButton(
                onPressed: () {
                  // check값 바꾸기
                  checkCard(id);
                },
                elevation: 0,
                fillColor: Colors.white,
                child: id == checkedId
                    ? Icon(
                        Icons.check_rounded,
                        size: 25.0,
                        color: Color(0xFFFF6280),
                      )
                    : Text(""),
                padding: EdgeInsets.all(0.0),
                shape: CircleBorder(
                  side: BorderSide(
                    width: 3,
                    color:
                        id == checkedId ? Color(0xFFFF6280) : Color(0xFFD7A859),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
