import 'package:flutter/material.dart';
import 'package:inglo/screens/solution_sketch/solution_drawing.dart';

class SolutionSketchBtn extends StatelessWidget {
  const SolutionSketchBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SolutionDrawingPage(),
          ),
        );
      },
      constraints: BoxConstraints(
        maxHeight: 100,
        maxWidth: 100,
      ),
      elevation: 0,
      fillColor: Color(0xFFFFD691),
      child: Icon(
        Icons.brush_rounded,
        size: 30.0,
        color: Color(0xFF233A66),
      ),
      padding: EdgeInsets.all(7.0),
      shape: CircleBorder(
        side: BorderSide(
          width: 1,
          color: Color(0xFF233A66),
        ),
      ),
    );
  }
}
