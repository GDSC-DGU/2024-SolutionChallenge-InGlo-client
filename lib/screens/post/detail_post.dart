import 'package:flutter/material.dart';
import 'package:inglo/screens/post/widgets/image_slider.dart';
import 'package:inglo/screens/post/widgets/post_user.dart';
import 'package:inglo/util/dummy/users_sketch.dart';
import 'package:inglo/widgets/dropdown/writingdropdown.dart';

class DetailPost extends StatelessWidget {
  const DetailPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // This ensures alignment starts from the left
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context); // 이전 페이지로 이동
                    },
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.bookmark), // 여기서 원하는 아이콘을 선택합니다.
                    color: Color(0xFFFF6280), // 아이콘 색상
                    onPressed: () {
                      // 버튼이 눌렸을 때 수행할 작업
                    },
                    iconSize: 30.0,
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Padding( // Using Padding for consistency and to apply padding
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Adjusts alignment to the left
                children: [
                  SizedBox(
                    height: 200,
                    child: ImageSlider(),
                  ),
                  SizedBox(height: 20),
                  Text('Title',
                    style: TextStyle(
                      fontSize: 26, // 폰트 크기 설정
                      fontWeight: FontWeight.bold, // 폰트 굵기 설정
                      color: Colors.black, // 텍스트 색상 설정
                    ),
                  ),
                  Text('description',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black, // 텍스트 색상 설정
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 30,
                    child: PostUser(),
                  ),
                  Text('content',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black, // 텍스트 색상 설정
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
