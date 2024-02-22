import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inglo/screens/solution_sketch/solution_drawing.dart';

class SolutionSketchBtn extends StatelessWidget {
  final getImage;
  final finishDrawing;
  const SolutionSketchBtn({
    required this.getImage,
    required this.finishDrawing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RawMaterialButton(
          onPressed: () {
            getImage(ImageSource.gallery); //getImage 함수를 호출해서 갤러리에서 사진 가져오기
          },
          constraints: const BoxConstraints(
            maxHeight: 100,
            maxWidth: 100,
          ),
          elevation: 0,
          fillColor: const Color(0xFFFFD691),
          padding: const EdgeInsets.all(7.0),
          shape: const CircleBorder(
            side: BorderSide(
              width: 1,
              color: Color(0xFF233A66),
            ),
          ),
          child: const Icon(
            Icons.photo_camera_back_outlined,
            size: 30.0,
            color: Color(0xFF233A66),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        RawMaterialButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    SolutionDrawingPage(finishDrawing: finishDrawing),
              ),
            );
            // navigateDrawing(context);
          },
          constraints: const BoxConstraints(
            maxHeight: 100,
            maxWidth: 100,
          ),
          elevation: 0,
          fillColor: const Color(0xFFFFD691),
          padding: const EdgeInsets.all(7.0),
          shape: const CircleBorder(
            side: BorderSide(
              width: 1,
              color: Color(0xFF233A66),
            ),
          ),
          child: const Icon(
            Icons.brush_rounded,
            size: 30.0,
            color: Color(0xFF233A66),
          ),
        ),
      ],
    );
  }
}
