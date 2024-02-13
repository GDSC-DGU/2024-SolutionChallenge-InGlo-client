import 'package:flutter/material.dart';

class SolutionSketchImg extends StatelessWidget {
  final String imageData;
  const SolutionSketchImg({required this.imageData, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(
              width: 3,
              color: Color(0xFF233A66),
            ),
          ),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Image.network(imageData, fit: BoxFit.cover, width: 150.0)),
        ),
        Positioned(
          top: -5,
          right: -25,
          child: RawMaterialButton(
            onPressed: () {
              // check값 바꾸기
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
