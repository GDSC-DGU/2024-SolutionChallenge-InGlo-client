import 'package:flutter/material.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.arrow_back),
                const SizedBox(
                  width: 20,
                ),
                Text('Create Post'),
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () {},
                  child: Text('Post'),
                )
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 140, // 너비
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.grey),
                          onPressed: () {},
                          icon: Icon(Icons.select_all, size: 20,),
                          label: Row(
                            children: [
                              Text('Sketch'),
                              Icon(
                                  Icons.arrow_drop_down,
                                ),
                            ],
                          ),
                        ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text("sketch title"),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(20), // form 패딩 설정
              child: Form(
                child: Column(
                  children: [
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
