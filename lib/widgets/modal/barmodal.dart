import 'package:flutter/material.dart';
import 'package:inglo/screens/comment/widgets/comment.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class BarModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.end, // 오른쪽 정렬
        children: [
          InkWell(
              onTap: () => showBarModalBottomSheet(
                expand: false,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => CommentPage(),
              ),
              child: Container(
                width: 60, // 화면 너비에서 양쪽 여백을 뺀 크기
                height: 60, // 높이 설정
                decoration: BoxDecoration(
                  color: Color(0xFFF7EEDE), // 배경색은 노란색
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(
                    color: Color(0xFFD7A859),
                    width: 1,
                  )
                ),
                child: Container(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
                      children: [
                        Icon(Icons.comment, color: Color(0xFFD7A859), size: 30,), // 댓글 아이콘
                      ],
                    ),
                  ),
                ),

              ),
          ),
        ],
      ),
    );
  }
}