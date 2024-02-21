import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/provider/user_token/user_token.dart';
import 'package:inglo/screens/detail_sketch/widgets/detail_sketch_steps.dart';
import 'package:inglo/screens/profile/widgets/mydrawing.dart';
import 'package:inglo/service/my_drawing/my_drawing_service.dart';
import 'package:provider/provider.dart';

class DetailSketch1Page extends StatefulWidget {
  final int sketchId;
  const DetailSketch1Page({required this.sketchId, super.key});

  @override
  State<DetailSketch1Page> createState() => _DetailSketch1PageState();
}

class _DetailSketch1PageState extends State<DetailSketch1Page> {
  @override
  Widget build(BuildContext context) {
    final int sketchId = widget.sketchId;
    final token = context.watch<UserToken>().token;

    return Scaffold(
      backgroundColor: Color(0xFFF7EEDE),
      // 상단 app 바로 뒤로가기 만들기!
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 25,),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MyDrawing(),
              ),
            );
          },
        ),
        title: Text(
          "Problem Definition",
          style: GoogleFonts.notoSans(
              color: Color(0xFF233A66),
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: Color(0xFFF7EEDE),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(10, 0, 10, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DetailSketchSteps(
              step: 1,
              sketchId: sketchId,
            ),
            Stack(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                        color: Color(0xFFFFD691),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                        offset: Offset(8, 8),
                      ),
                    ],
                  ),
                  child: FutureBuilder(
                    future:
                        MyDrawingService().getMyDrawingDetail(sketchId, token),
                    builder: (context, snapshot) {
                      var data = snapshot.data!;
                      return TextFormField(
                        readOnly: true,
                        initialValue: data.problem,
                        keyboardType: TextInputType.multiline, // 여러 줄
                        maxLines: null, // 자동 줄 바꿈
                        minLines: 10,
                        style: GoogleFonts.cabinSketch(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 50,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          width: 20,
                          image: Svg('assets/image/design/single_spring.svg'),
                        ),
                        Image(
                          width: 20,
                          image: Svg('assets/image/design/single_spring.svg'),
                        ),
                        Image(
                          width: 20,
                          image: Svg('assets/image/design/single_spring.svg'),
                        ),
                        Image(
                          width: 20,
                          image: Svg('assets/image/design/single_spring.svg'),
                        ),
                        Image(
                          width: 20,
                          image: Svg('assets/image/design/single_spring.svg'),
                        ),
                        Image(
                          width: 20,
                          image: Svg('assets/image/design/single_spring.svg'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
