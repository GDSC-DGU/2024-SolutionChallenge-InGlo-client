import 'package:flutter/material.dart';

class LoadingIndicatorWidget extends StatefulWidget {
  @override
  _LoadingIndicatorWidgetState createState() => _LoadingIndicatorWidgetState();
}

class _LoadingIndicatorWidgetState extends State<LoadingIndicatorWidget> {
  bool isLoading = false;

  void startLoading() {
    setState(() {
      isLoading = true;
    });

    // 여기서 비동기 작업을 시작합니다.
    // 예를 들어, Future.delayed를 사용하여 시뮬레이션할 수 있습니다.
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        isLoading = false; // 5초 후에 로딩 상태를 false로 설정하여 인디케이터를 숨깁니다.
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로딩 인디케이터 데모'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator() // 로딩 상태일 때 인디케이터 표시
            : ElevatedButton(
          onPressed: () {
            startLoading(); // 버튼 클릭 시 로딩 시작
          },
          child: Text('로딩 시작'),
        ),
      ),
    );
  }
}
