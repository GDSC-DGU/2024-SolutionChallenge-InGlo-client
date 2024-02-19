import 'package:flutter/material.dart';

// count 상태 정의
// provider 사용을 위해서는 ChangeNotifier을 사용하여 클래스를 생성 해야한다.
class Counts with ChangeNotifier {
  // 앱 내의 공통된 상태 변수를 선언한다. 또한, 외부에서 접근할 수 있도록 getter도 생성한다.
  int _count = 0;
  int get count => _count;

  // 상태 변수를 변경하는 함수들
  // 여기서 중요한 점은 변수를 수정하였다면 notifyListeners()를 실행하여, 데이터가 갱신되었음을 통보한다.!!!
  // setState와 비슷한 맥락이다.
  void add() {
    _count++; // add 함수, 1을 추가한다.
    notifyListeners();
  }

  void remove() {
    _count--; // remove 함수, 1을 제거한다.
    notifyListeners();
  }
}