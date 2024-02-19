import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inglo/provider/test/counts.dart'; // 상대 변수 가져오기

class Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              // counter.dart와 다르게, 값 변경을 위해 context.read<Counts>()를 사용하여
              // add와 remove를 호출한다.
              context.read<Counts>().add();
            },
            child: Icon(Icons.add)),
        SizedBox(
          width: 40,
        ),
        ElevatedButton(
            onPressed: () {
              context.read<Counts>().remove();
            },
            child: Icon(Icons.remove))
      ],
    );
  }
}