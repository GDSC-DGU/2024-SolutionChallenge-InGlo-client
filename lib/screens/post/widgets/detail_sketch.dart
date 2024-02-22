import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/provider/user_token/user_token.dart';
import 'package:inglo/screens/detail_sketch/widgets/detail_sketch4_content.dart';
import 'package:inglo/screens/detail_sketch/widgets/detail_sketch_steps.dart';
import 'package:inglo/screens/post/widgets/selected_sketch.dart';
import 'package:inglo/screens/profile/widgets/mydrawing.dart';
import 'package:inglo/service/my_drawing/my_drawing_service.dart';
import 'package:provider/provider.dart';

class SeeDetailSketch extends StatefulWidget {
  final int sketchId;
  const SeeDetailSketch({required this.sketchId, super.key});

  @override
  State<SeeDetailSketch> createState() => _SeeDetailSketchState();
}

class _SeeDetailSketchState extends State<SeeDetailSketch> {
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
                builder: (context) => SelectedSketch(),
              ),
            );
          },
        ),
        title: Text(
          "Solution sketch",
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
            child: FutureBuilder(
              future: MyDrawingService().getMyDrawingDetail(sketchId, token),
              builder: (context, snapshot) {
                var data = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DetailSketchSteps(
                      step: 4,
                      sketchId: sketchId,
                    ),
                    if (data.imageUrl != "")
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        //width: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(
                            width: 3,
                            color: Color(0xFF233A66),
                          ),
                        ),
                        child: ClipRRect(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                            child: Image.network(data.imageUrl,
                                fit: BoxFit.cover, width: 150.0)),
                      ),
                    DetailSketch4Content(data: data,),
                  ],
                );
              },
            ),
          )),
    );
  }
}
