import 'package:flutter/material.dart';
import 'package:inglo/screens/post/create_post.dart';
import 'package:inglo/widgets/appbar/appbar.dart';
import 'package:inglo/widgets/dropdown/dropdownbutton.dart';
import 'package:inglo/screens/postlist/widgets/post_item.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:convert';

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:inglo/util/post/postlist.dart';
import 'package:inglo/models/post/post_list.dart';


class PostBoardPage extends StatefulWidget {
  @override
  State<PostBoardPage> createState() => _PostBoardPageState();
}

class _PostBoardPageState extends State<PostBoardPage> {
  final dio = Dio(); // dio instance 생성
  final List<PostList> _listItems = [];

  // 초기 1번 실행
  void initState() {
    super.initState();
    getPostItems();
  }

  // profile get 함수
  Future<void> getPostItems() async {
    final url = "https://dongkyeom.com/api/v1/posts/";

    try {
      final response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA4NTc3MDgwLCJpYXQiOjE3MDg0MzMwODAsImp0aSI6IjU1YWYyZjg2Y2I2NzQxOTFiMWQ5OWI0MjNhZmMxODEyIiwidXNlcl9pZCI6M30.ws5KsW_fBY-Kun1u3Rexkvnyjwz6_uN0PBqTnw7BKYs',
          },
        ),
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
        print('성공!');
        final List<dynamic> jsonResponse = jsonDecode(response.data);
        print('data : ${jsonResponse[0]['id']}');
        setState(() {
          _listItems.clear(); // 기존 목록을 지우고 새로운 데이터로 채운다.
          for (var item in jsonResponse) {
            _listItems.add(PostList.fromJson(item));
          }
        });
      }


    } catch (e) {
      // 요청 실패 또는 기타 에러 처리
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: Stack(
            // Stack 위젯을 사용하여 겹치는 효과 구현
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70,
                    child: CustomDropdown(),
                  ),
                  Container(
                    child: Text(
                      "Recents",
                      style: GoogleFonts.notoSans(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          PostItem(listItems : _listItems), // PostItem 호출
                          SizedBox(height: 0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                // FloatingActionButton을 Positioned로 배치하여 위치 조정
                right: 0,
                bottom: 0,
                child: FloatingActionButton.extended(
                  heroTag: 'uniqueTag1', // 고유 태그
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CreatePost(),
                      ),
                    );
                  },
                  backgroundColor: const Color(0xFF233A66),
                  label: const Icon(
                    Icons.post_add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationAppBar(
        currentIndex: 2, // index 전송
      ),
    );
  }
}
