import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/util/sketch/sketchlist_preference.dart';

import 'package:vertical_card_pager/vertical_card_pager.dart';

import 'package:dio/dio.dart';

class MyPosting extends StatefulWidget {
  @override
  _MyPostingState createState() => _MyPostingState();
}

class _MyPostingState extends State<MyPosting> {
  final dio = Dio(); // dio instance 생성

  // 초기 1번 실행
  void initState() {
    super.initState();
    getPosts();
  }

  // profile get 함수
  Future<void> getPosts() async {
    final url = "https://dongkyeom.com/api/v1/sketches/";

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

      String responseBody = response.data;

      if(response.statusCode == 200 || response.statusCode == 201) {
        print('성공!');
      }
      print('data : $responseBody');

    } catch (e) {
      // 요청 실패 또는 기타 에러 처리
      print('Error fetching data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    final list = SketchListPreferences.mySketchList;
    final List<String> titles = list.map((sketch) => '').toList();

    final List<Widget> images = list
        .map((sketch) => Container(
      clipBehavior: Clip.antiAlias, // 모서리를 둥글게 처리한 부분을 넘어서는 내용을 잘라냅니다.
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFF7EEDE),
              image: DecorationImage(
                image: NetworkImage(sketch.image_url),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2), // 반투명한 오버레이 색상
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Column을 내용물 크기에 맞게 조정
                mainAxisAlignment: MainAxisAlignment.center, // 수직 방향 중앙 정렬
                crossAxisAlignment: CrossAxisAlignment.start, // 수평 방향 좌측 정렬
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          sketch.title,
                          style: GoogleFonts.notoSans(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                          overflow: TextOverflow.ellipsis, // 넘치는 텍스트 처리
                        ),
                      ),
                      Flexible(
                        child: Container(
                          child: Text(
                            sketch.created_at,
                            style: GoogleFonts.notoSans(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12),
                            overflow: TextOverflow.ellipsis, // 넘치는 텍스트 처리
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                      child: Text(
                        sketch.description, // 여기에 원하는 텍스트를 추가
                        style: GoogleFonts.notoSans(
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context); // 이전 페이지로 이동
          },
        ),
        title: Text('MY DRAWINGS'),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: VerticalCardPager(
                    textStyle: GoogleFonts.notoSans(
                      color: Colors.white,
                      fontWeight: FontWeight.w400, // 폰트 두께를 bold로 변경
                      fontSize: 12, // 폰트 크기를 22로 변경
                    ),
                    titles: titles,
                    images: images,
                    initialPage: 0,
                    onPageChanged: (page) {},
                    align: ALIGN.CENTER,
                    onSelectedItem: (index) {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
