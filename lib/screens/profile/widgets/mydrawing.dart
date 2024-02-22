import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/models/my_drawing/my_drawing_model.dart';
import 'package:inglo/provider/user_token/user_token.dart';
import 'package:inglo/screens/detail_sketch/detail_sketch4.dart';
import 'package:inglo/screens/profile/profile.dart';
import 'package:inglo/service/my_drawing/my_drawing_service.dart';
import 'package:inglo/util/sketch/sketchlist_preference.dart';
import 'package:provider/provider.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

import 'package:dio/dio.dart';

class MyDrawing extends StatefulWidget {
  const MyDrawing({super.key});

  @override
  _MyDrawingState createState() => _MyDrawingState();
}

class _MyDrawingState extends State<MyDrawing> {
  @override
  Widget build(BuildContext context) {
    final token = context.watch<UserToken>().token;
    titles(List<MyDrawingListModel> list) {
      return list.map((sketch) => sketch.title).toList();
    }

    images(List<MyDrawingListModel> list) {
      return list
          .map((sketch) => Container(
                clipBehavior:
                    Clip.antiAlias, // 모서리를 둥글게 처리한 부분을 넘어서는 내용을 잘라냅니다.
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7EEDE),
                        image: DecorationImage(
                          image: NetworkImage(sketch.imageUrl ?? ''),
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
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize:
                              MainAxisSize.min, // Column을 내용물 크기에 맞게 조정
                          mainAxisAlignment:
                              MainAxisAlignment.center, // 수직 방향 중앙 정렬
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // 수평 방향 좌측 정렬
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    sketch.description ?? '',
                                    style: GoogleFonts.notoSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    overflow:
                                        TextOverflow.ellipsis, // 넘치는 텍스트 처리
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    child: Text(
                                      sketch.createdAt.substring(0, 10) ??
                                          '0000-00-00',
                                      style: GoogleFonts.notoSans(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                      overflow:
                                          TextOverflow.ellipsis, // 넘치는 텍스트 처리
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 0),
                                child: Text(
                                  sketch.content ?? '', // 여기에 원하는 텍스트를 추가
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
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
            );
          },
        ),
        title: const Text('MY DRAWINGS'),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: MyDrawingService().getMyDrawingList(token),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.hasError) {
                        return const Center(child: Text('error')); // 에러 발생 시
                      } else {
                        var data = snapshot.data!;
                        return VerticalCardPager(
                          textStyle: GoogleFonts.notoSans(
                            color: Colors.white,
                            fontWeight: FontWeight.w400, // 폰트 두께를 bold로 변경
                            fontSize: 12, // 폰트 크기를 22로 변경
                          ),
                          titles: titles(data),
                          images: images(data),
                          initialPage: 0,
                          onPageChanged: (page) {},
                          align: ALIGN.CENTER,
                          onSelectedItem: (index) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailSketch4Page(sketchId: data[index].id),
                              ),
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
