import 'package:flutter/material.dart';
import 'package:inglo/util/dummy/users_sketch.dart';
import 'package:inglo/widgets/dropdown/writingdropdown.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({super.key});

  @override
  Widget build(BuildContext context) {

    // MediaQuery를 사용하여 화면의 너비를 얻음
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context); // 이전 페이지로 이동
                    },
                  ),
                  Text('Create Post',
                    style: TextStyle(
                      fontSize: 16, // 폰트 크기 설정
                      fontWeight: FontWeight.bold, // 폰트 굵기 설정
                      color: Colors.black, // 텍스트 색상 설정
                    ),),
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFD691)),
                    onPressed: () {},
                    child: Text('Post',
                      style: TextStyle(
                        fontSize: 16, // 폰트 크기 설정
                        fontWeight: FontWeight.bold, // 폰트 굵기 설정
                        color: Colors.white, // 텍스트 색상 설정
                      ),),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Form(
                child: Column(
                  children: [
                    SizedBox(
                      height: 45.0,
                      child: WritingCustomDropdown(options: usersSketchData),),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLines: null,
                      maxLength: 50, // 사용자가 입력할 수 있는 최대 문자 수
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Add Title...",
                        contentPadding: EdgeInsets.all(0),
                        hintStyle: TextStyle(fontSize: 20),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 0), // 두 입력 필드 사이의 공간 추가
                    TextFormField(
                      maxLines: null, // 무제한 줄 입력 허용
                      keyboardType: TextInputType.multiline, // 멀티라인 입력 활성화
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Add Content...",
                        contentPadding: EdgeInsets.all(0),
                        hintStyle: TextStyle(fontSize: 14),
                        isDense: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
