import 'package:flutter/material.dart';
import 'package:inglo/screens/post/detail_post.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/models/post/post_list.dart';
import 'package:inglo/util/post/postlist.dart';
import 'package:dio/dio.dart';

// 선 위젯
Widget buildDivider(BuildContext context) => Container(
      width: MediaQuery.of(context).size.width,
      child: Divider(),
    );

class PostItem extends StatefulWidget {
  const PostItem({Key? key}) : super(key: key);

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  final dio = Dio(); // dio instance 생성
  // 기존의 StatelessWidget 내부 로직을 여기로 옮깁니다.
  final _listItem = PostListPreferences.listItem;

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
            'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA4NTcxMDcwLCJpYXQiOjE3MDg0MjcwNzAsImp0aSI6IjNhNTJjOTkzODczNTRiNmM4NzNlYjc4MzU0NDNmOWVlIiwidXNlcl9pZCI6M30.d7lTdqfIBZuskzHKBvclwYKNeVE4-SepdmPggZghMSM',
          },
        ),
      );

      String responseBody = response.data;

      print('get data : $responseBody');


    } catch (e) {
      // 요청 실패 또는 기타 에러 처리
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> itemListData = _listItem.map((item) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailPost(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 0, 4),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    child: Text(
                                      item.title!,
                                      style: GoogleFonts.notoSans(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis, // 최대 텍스트 줄
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: ClipRRect(
                                      // ClipRRect를 사용하여 이미지도 borderRadius를 적용
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset(
                                        getSdgsImage(item.sdgs),
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.cover, // container에 딱 맞게
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                  width: 200,
                                  child: Text(
                                    item.content!,
                                    style: GoogleFonts.notoSans(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              SizedBox(height: 3),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${item.created_at} | ${item.user}',
                                          style: GoogleFonts.notoSans(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.favorite_border_outlined,
                                          color: Color(0xFFD7A859),
                                          size: 12.0,
                                        ),
                                        Text(
                                          '${item.likes}',
                                          style: GoogleFonts.notoSans(
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              buildDivider(context),
            ],
          ),
        ),
      );
    }).toList();

    return Container(
      child: Column(
        children: itemListData,
      ),
    );
  }
}

// sdgs 이미지 반환 로직
String getSdgsImage(int index) {
  switch (index) {
    case 1:
      return 'assets/image/sdgs/sdgs1.png';
    case 2:
      return 'assets/image/sdgs/sdgs2.png';
    case 3:
      return 'assets/image/sdgs/sdgs3.png';
    case 4:
      return 'assets/image/sdgs/sdgs4.png';
    case 5:
      return 'assets/image/sdgs/sdgs5.png';
    case 6:
      return 'assets/image/sdgs/sdgs6.png';
    case 7:
      return 'assets/image/sdgs/sdgs7.png';
    case 8:
      return 'assets/image/sdgs/sdgs8.png';
    case 9:
      return 'assets/image/sdgs/sdgs9.png';
    case 10:
      return 'assets/image/sdgs/sdgs10.png';
    case 11:
      return 'assets/image/sdgs/sdgs11.png';
    case 12:
      return 'assets/image/sdgs/sdgs12.png';
    case 13:
      return 'assets/image/sdgs/sdgs13.png';
    case 14:
      return 'assets/image/sdgs/sdgs14.png';
    case 15:
      return 'assets/image/sdgs/sdgs15.png';
    case 16:
      return 'assets/image/sdgs/sdgs16.png';
    case 17:
      return 'assets/image/sdgs/sdgs17.png';
    default:
      return 'assets/image/sdgs/sdgs1.png'; // 기본 이미지 경로
  }
}
