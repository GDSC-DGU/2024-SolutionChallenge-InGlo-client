import 'package:flutter/material.dart';
import 'package:inglo/screens/comment/widgets/comment.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class BarModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showBarModalBottomSheet(
            expand: false,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => CommentPage(),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width, // 화면 너비에서 양쪽 여백을 뺀 크기
            height: 80, // 높이 설정
            decoration: BoxDecoration(
              color: Color(0xFFF7EEDE), // 배경색은 노란색
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
              border: Border.all(
                color: Color(0xFF233A66),
                width: 1,
              )
            ),
            child: Center(
              child: ListTile(
                title: Text(
                  '6 comments',
                  style: TextStyle(color: Color(0xFF233A66), fontSize: 14), // `ListTile` 제목 스타일
                ),
                trailing: Icon(Icons.comment, color: Color(0xFF233A66)), // 댓글 아이콘 추가
              ),
            ),
          ),
        ),
      ),
    );
  }
}