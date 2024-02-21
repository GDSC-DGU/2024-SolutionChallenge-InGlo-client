import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/screens/crazy/crazy_8s.dart';
import 'package:inglo/screens/hmw/hmw_detail.dart';
import 'package:inglo/screens/problem_definition/problem_definition.dart';
import 'package:inglo/screens/solution_sketch/solution_sketch.dart';

class DesignSteps extends StatelessWidget {
  final int step;
  final int sdgs;

  const DesignSteps({
    required this.step,
    required this.sdgs,
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
          margin: EdgeInsets.fromLTRB(30, 25, 30, 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color(0xFFC4C4C4),
          ),
        ),
        Positioned(
          top: 3,
          left: -10,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
                              builder: (context) => ProblemDefinitionPage(
                                sdgs: sdgs,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            step == 1 ? Color(0xFF233A66) : Color(0xFFC4C4C4),
                        shape: CircleBorder(),
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
                        // if (step != 2) {
                        //   Navigator.of(context).push(
                        //     MaterialPageRoute(
                        //       builder: (context) => HMWDetailPage(
                        //         sdgs: sdgs,
                        //       ),
                        //     ),
                        //   );
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            step == 2 ? Color(0xFF233A66) : Color(0xFFC4C4C4),
                        shape: CircleBorder(),
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
                            step == 2 ? Color(0xFF233A66) : Color(0xFFC4C4C4),
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // if (step != 3) {
                        //   Navigator.of(context).push(
                        //     MaterialPageRoute(
                        //       builder: (context) => Crazy8sPage(
                        //         sdgs: sdgs,
                        //       ),
                        //
                        //     ),
                        //   );
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            step == 3 ? Color(0xFF233A66) : Color(0xFFC4C4C4),
                        shape: CircleBorder(),
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
                            step == 3 ? Color(0xFF233A66) : Color(0xFFC4C4C4),
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // if (step != 4) {
                        //   Navigator.of(context).push(
                        //     MaterialPageRoute(
                        //       builder: (context) => SolutionSketchPage(
                        //         sdgs: sdgs,
                        //       ),
                        //     ),
                        //   );
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            step == 4 ? Color(0xFF233A66) : Color(0xFFC4C4C4),
                        shape: CircleBorder(),
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
                            step == 4 ? Color(0xFF233A66) : Color(0xFFC4C4C4),
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
