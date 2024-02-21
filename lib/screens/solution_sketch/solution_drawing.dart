import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/screens/solution_sketch/widgets/solution_drawing_board.dart';
import 'package:scribble/scribble.dart';

class SolutionDrawingPage extends StatefulWidget {
  final finishDrawing;
  const SolutionDrawingPage({required this.finishDrawing, super.key});

  @override
  State<SolutionDrawingPage> createState() => _SolutionDrawingPageState();
}

class _SolutionDrawingPageState extends State<SolutionDrawingPage> {
  late ScribbleNotifier notifier;

  @override
  void initState() {
    notifier = ScribbleNotifier();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final finishDrawing = widget.finishDrawing;

    Future<void> saveImage(BuildContext context) async {
      final image = await notifier.renderImage();
      finishDrawing(image);
      Navigator.pop(context);
      // Navigator.pop(context, image.buffer.asUint8List());
      // showDialog(
      //   context: context,
      //   builder: (context) => AlertDialog(
      //     title: Text("Your Image", style: GoogleFonts.notoSans(fontWeight: FontWeight.w700, fontSize: 20,),),
      //     content: Image.memory(image.buffer.asUint8List()),
      //   ),
      // );
    }

    return Scaffold(
      backgroundColor: Color(0xFFF7EEDE),
      // 상단 app 바로 뒤로가기 만들기!
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 25,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Solution Drawing",
          style: GoogleFonts.notoSans(
              color: Color(0xFF233A66),
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: Color(0xFFF7EEDE),
        actions: <Widget>[
          Container(
            margin:
            const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () => saveImage(context),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                side: BorderSide(
                  color: Color(0xFF233A66),
                  width: 1,
                ),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
              ),
              child: Text(
                'finish',
                style: GoogleFonts.notoSans(
                  color: Color(0xFF233A66),
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SolutionDrawingBoard(notifier: notifier,),
            ],
          ),
        ),
      ),
    );

  }


}
