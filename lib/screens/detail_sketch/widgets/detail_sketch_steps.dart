import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/screens/detail_sketch/detail_sketch1.dart';
import 'package:inglo/screens/detail_sketch/detail_sketch2.dart';
import 'package:inglo/screens/detail_sketch/detail_sketch3.dart';
import 'package:inglo/screens/detail_sketch/detail_sketch4.dart';

class DetailSketchSteps extends StatelessWidget {
  final int step;
  final int sketchId;

  const DetailSketchSteps({
    required this.step,
    required this.sketchId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 3,
          margin: const EdgeInsets.fromLTRB(30, 25, 30, 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: const Color(0xFFC4C4C4),
          ),
        ),
        Positioned(
          top: 3,
          left: -10,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (step != 1) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailSketch1Page(
                                sketchId: sketchId,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            step == 1 ? const Color(0xFF233A66) : const Color(0xFFC4C4C4),
                        shape: const CircleBorder(),
                        // padding도 넣을 수 있음!
                      ),
                      child: Text(
                        "1",
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      "problem",
                      style: GoogleFonts.notoSans(
                        color:
                            step == 1 ? Color(0xFF233A66) : Color(0xFFC4C4C4),
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (step != 2) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailSketch2Page(
                                sketchId: sketchId,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            step == 2 ? const Color(0xFF233A66) : const Color(0xFFC4C4C4),
                        shape: const CircleBorder(),
                        // padding도 넣을 수 있음!
                      ),
                      child: Text(
                        "2",
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      "HMW",
                      style: GoogleFonts.notoSans(
                        color:
                            step == 2 ? const Color(0xFF233A66) : const Color(0xFFC4C4C4),
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (step != 3) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailSketch3Page(
                                sketchId: sketchId,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            step == 3 ? const Color(0xFF233A66) : const Color(0xFFC4C4C4),
                        shape: const CircleBorder(),
                        // padding도 넣을 수 있음!
                      ),
                      child: Text(
                        "3",
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      "crazy 8's",
                      style: GoogleFonts.notoSans(
                        color:
                            step == 3 ? const Color(0xFF233A66) : const Color(0xFFC4C4C4),
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (step != 4) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailSketch4Page(
                                sketchId: sketchId,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            step == 4 ? const Color(0xFF233A66) : const Color(0xFFC4C4C4),
                        shape: const CircleBorder(),
                        // padding도 넣을 수 있음!
                      ),
                      child: Text(
                        "4",
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      "sketch",
                      style: GoogleFonts.notoSans(
                        color:
                            step == 4 ? const Color(0xFF233A66) : const Color(0xFFC4C4C4),
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
