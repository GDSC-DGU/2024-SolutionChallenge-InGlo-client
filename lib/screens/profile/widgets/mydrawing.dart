import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/models/sketch/sketch.dart';
import 'package:inglo/util/sketch/sketchlist_preference.dart';

import 'package:vertical_card_pager/vertical_card_pager.dart';

class MyDrawing extends StatefulWidget {
  @override
  _MyDrawingState createState() => _MyDrawingState();
}

class _MyDrawingState extends State<MyDrawing> {
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
                                Expanded( // 제목을 더 큰 공간에 할당합니다.
                                  flex: 4, // 공간 비율을 조절하여 다른 Text에 비해 더 많은 공간을 할당
                                  child: Text(
                                    sketch.title,
                                    style: GoogleFonts.notoSans(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                                    overflow: TextOverflow.ellipsis, // 넘치는 텍스트 처리
                                  ),
                                ),
                                Flexible( // 생성 날짜에 유연한 공간 할당
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
                                textAlign: TextAlign.center,
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
