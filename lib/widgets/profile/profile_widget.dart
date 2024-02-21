import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/widgets/gauge/range_pointer/range_pointer.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final double global_impact;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.global_impact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 110, // 첫 번째 컨테이너의 크기를 명시적으로 지정해야 한다.
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(10), // 원하는 패딩 설정
          ),
          Positioned(
            left: 5, // 상위 width 차이 10의 절반
            top: 5,
            child: Container(
              width: 100,
              height: 100,
              child: buildImage(),
            ),
          ),
          Positioned(
            left: 5,
            top: 5,
            child: Container(
              width: 100,
              height: 100,
              child: RangePointerExample(global_impact: global_impact),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 100,
          height: 100,
        ),
      ),
    );
  }

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
