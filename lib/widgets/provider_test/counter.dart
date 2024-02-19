import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inglo/provider/test/counts.dart'; // 상태 변수 추가

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Counter');

    return Text(
      // context.watch<Counts>().count 를 사용하여 count 값이 변경되는 것을 확인한다.
      // 이 때, counts는 provider의 class 이름
      context.watch<Counts>().count.toString(),
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }
}