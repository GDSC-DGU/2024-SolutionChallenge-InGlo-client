import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/provider/user_token/user_token.dart';
import 'package:inglo/screens/detail_sketch/widgets/detail_sketch_steps.dart';
import 'package:inglo/screens/problem_definition/widgets/design_card.dart';
import 'package:inglo/screens/profile/widgets/mydrawing.dart';
import 'package:inglo/service/my_drawing/my_drawing_service.dart';
import 'package:provider/provider.dart';

class DetailSketch3Page extends StatefulWidget {
  final int sketchId;

  const DetailSketch3Page({required this.sketchId, super.key});

  @override
  State<DetailSketch3Page> createState() => _DetailSketch3PageState();
}

class _DetailSketch3PageState extends State<DetailSketch3Page> {
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
          "Crazy 8's",
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
              step: 3,
              sketchId: sketchId,
            ),
            FutureBuilder(
              future: MyDrawingService().getMyDrawingDetail(sketchId, token),
              builder: (context, snapshot) {
                var data = snapshot.data!;
                return data.crazy8stack.length != 0 ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: MasonryGridView.count(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.crazy8stack.length,
                    crossAxisCount: 2,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    itemBuilder: (context, index) {
                      return DesignCard(
                          content: data.crazy8stack[index]["content"]!);
                    },
                  ),
                ) : Container(
                  margin: EdgeInsets.symmetric(vertical: 70),
                  alignment: Alignment.center,
                  child: Text("No writing has been made.", style: GoogleFonts.notoSans(fontSize: 16, color: Colors.black38, fontWeight: FontWeight.w600,),),);
              },
            ),
          ],
        ),
      )),
    );
  }
}
