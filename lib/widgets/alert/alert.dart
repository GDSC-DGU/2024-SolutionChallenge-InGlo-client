// lib/widgets/custom_alert_dialog.dart
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onConfirm;

  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.message,
    this.buttonText = '확인',
    required this.onConfirm,
  }) : super(key: key);

  void showCustomDialogWithAutoDismiss(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: '생성 불가',
          message: '보유하고 있는 스케치가 없습니다.',
          onConfirm: () {
            Navigator.of(context).pop(); // Alert Dialog를 닫습니다.
          },
        );
      },
    );

    // 2초 후 자동으로 Dialog를 닫고 이전 화면으로 돌아갑니다.
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop(); // 첫 번째 pop은 AlertDialog를 닫습니다.
      Navigator.of(context).pop(); // 두 번째 pop은 이전 화면으로 돌아갑니다.
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: Text(buttonText),
          onPressed: onConfirm,
        ),
      ],
    );
  }
}
