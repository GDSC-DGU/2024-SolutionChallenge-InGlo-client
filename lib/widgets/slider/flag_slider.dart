import 'dart:async';
import 'package:flutter/material.dart';

class InfiniteFlagSlider extends StatefulWidget {
  final List<String> flagImages;

  InfiniteFlagSlider({Key? key, required this.flagImages}) : super(key: key);

  @override
  _InfiniteFlagSliderState createState() => _InfiniteFlagSliderState();
}

class _InfiniteFlagSliderState extends State<InfiniteFlagSlider> {
  final PageController _pageController = PageController(
    viewportFraction: 0.9, // 페이지 뷰에서 각 페이지의 차지하는 비율
    initialPage: 0,
  );
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_pageController.page! + 1).toInt();
        if (nextPage >= widget.flagImages.length) {
          nextPage = 0; // 처음으로 돌아가도록 설정
        }
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 10),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 20, // ListView에 명시적인 높이 제공
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.flagImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0), // 국기 이미지간 간격 추가
            child: Image.asset(widget.flagImages[index], fit: BoxFit.cover,),
          );
        },
      ),
    );
  }
}
