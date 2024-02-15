import 'package:flutter/material.dart';
import 'package:inglo/screens/post/widgets/image_slider.dart';
import 'package:inglo/screens/post/widgets/post_user.dart';
import 'package:inglo/widgets/modal/barmodal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DetailPost extends StatefulWidget {
  @override
  _DetailPostState createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {
  bool isBookmarked = false; // 북마크 상태

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height:  MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // This ensures alignment starts from the left
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
                          icon: isBookmarked ? Icon(Icons.bookmark) : Icon(Icons.bookmark_border), // 채워진 이미지와 outlined 이미지를 번갈아가며 표시
                          color: Color(0xFFFF6280), // 아이콘 색상
                          onPressed: () {
                            setState(() {
                              // 버튼이 눌릴 때마다 상태 변경
                              isBookmarked = !isBookmarked;
                            });
                          },
                          iconSize: 30.0,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 200,
                          child: ImageSlider(),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Title',
                          style: TextStyle(
                            fontSize: 26, // 폰트 크기 설정
                            fontWeight: FontWeight.bold, // 폰트 굵기 설정
                            color: Colors.black, // 텍스트 색상 설정
                          ),
                        ),
                        Text(
                          'description',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black, // 텍스트 색상 설정
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 30,
                          child: PostUser(),
                        ),
                        Text(
                          'content',
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
            Positioned(
              bottom: 20,
              left: 0,
              right: 20,
              child: SizedBox(
                height: 60,
                child: BarModal(),
              ),// 여기서 BarModalWidget은 바텀 모달의 컨텐츠를 표시하는 위젯입니다.
            ),
          ],
        ),
      ),
    );
  }
}
