import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/service/translate/translate_util.dart';

class CheckDesignCard extends StatelessWidget {
  final id;
  final checkedId;
  final checkCard;
  final String content;

  const CheckDesignCard({
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text("loading..."));
        } else {
          if (snapshot.hasError) {
            return const Center(child: Text('error')); // 에러 발생 시
          } else {
            var transData = snapshot.data!;
            return Stack(
              children: [
                Container(
                  //width: 150,
                  constraints: const BoxConstraints(
                    minWidth: 150,
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 3,
                      color: id == checkedId
                          ? const Color(0xFFFF6280)
                          : const Color(0xFFD7A859),
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFFFD691),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                        offset: Offset(6, 6),
                      ),
                    ],
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
                const Positioned(
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
                      checkCard(id);
                    },
                    elevation: 0,
                    fillColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    shape: CircleBorder(
                      side: BorderSide(
                        width: 3,
                        color: id == checkedId
                            ? const Color(0xFFFF6280)
                            : const Color(0xFFD7A859),
                      ),
                    ),
                    child: id == checkedId
                        ? const Icon(
                      Icons.check_rounded,
                      size: 25.0,
                      color: Color(0xFFFF6280),
                    )
                        : const Text(""),
                  ),
                ),
              ],
            );
          }
        }
      },
    );
  }
}
