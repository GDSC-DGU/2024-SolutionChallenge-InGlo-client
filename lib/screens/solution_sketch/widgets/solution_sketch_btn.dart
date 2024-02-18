import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inglo/screens/solution_sketch/solution_drawing.dart';

class SolutionSketchBtn extends StatelessWidget {
  final getImage;
  const SolutionSketchBtn({required this.getImage, super.key,});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RawMaterialButton(
          onPressed: () {
            getImage(ImageSource.gallery); //getImage 함수를 호출해서 갤러리에서 사진 가져오기
          },
          constraints: BoxConstraints(
            maxHeight: 100,
            maxWidth: 100,
          ),
          elevation: 0,
          fillColor: Color(0xFFFFD691),
          child: Icon(
            Icons.photo_camera_back_outlined,
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
        ),
        SizedBox(
          width: 10,
        ),
        RawMaterialButton(
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
      ),],
    );
  }
}
