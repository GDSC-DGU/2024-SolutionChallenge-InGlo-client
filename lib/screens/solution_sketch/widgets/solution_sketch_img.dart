import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SolutionSketchImg extends StatelessWidget {
  final File? imageData;
  final deleteImage;
  const SolutionSketchImg({required this.imageData, required this.deleteImage, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(
              width: 3,
              color: Color(0xFF233A66),
            ),
          ),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Image.file(imageData!, fit: BoxFit.cover, width: 150.0)),
        ),
        Positioned(
          top: -5,
          left: -20,
          child: RawMaterialButton(
            onPressed: () {
              // check값 바꾸기
              deleteImage();
            },
            elevation: 0,
            fillColor: Colors.white,
            child: Icon(
              Icons.cancel,
              size: 30.0,
              color: Color(0xFF233A66),
            ),
            padding: EdgeInsets.all(0.0),
            shape: CircleBorder(
              side: BorderSide(
                width: 3,
                color: Color(0xFF233A66),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
