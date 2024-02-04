import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

// homepage 생성
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: Svg(
                'assets/image/home/background.svg',
                // size: Size(10, 10), // size 지정 하던 안 하던 동일하다.
              ),
            )),
        child: const Scaffold(

        ));
  }
}
