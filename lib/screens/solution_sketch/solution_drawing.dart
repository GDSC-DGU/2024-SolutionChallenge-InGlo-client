import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/screens/solution_sketch/widgets/solution_drawing_board.dart';
import 'package:inglo/widgets/design/design_steps.dart';
import 'package:scribble/scribble.dart';

class SolutionDrawingPage extends StatefulWidget {
  const SolutionDrawingPage({super.key});

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
    return Scaffold(
      backgroundColor: Color(0xFFF7EEDE),
      // 상단 app 바로 뒤로가기 만들기!
      appBar: AppBar(
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
              onPressed: () => _saveImage(context),
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

  Future<void> _saveImage(BuildContext context) async {
    final image = await notifier.renderImage();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Your Image", style: GoogleFonts.notoSans(fontWeight: FontWeight.w700, fontSize: 20,),),
        content: Image.memory(image.buffer.asUint8List()),
      ),
    );
  }
}
