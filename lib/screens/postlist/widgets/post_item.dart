import 'package:flutter/material.dart';
import 'package:inglo/screens/post/detail_post.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:inglo/models/post/post_list.dart';

// 선 위젯
Widget buildDivider(BuildContext context) => Container(
      width: MediaQuery.of(context).size.width,
      child: Divider(),
    );

class PostItem extends StatefulWidget {
  final List<PostList> listItems; // 리스트를 저장할 변수

  // 생성자를 통해 리스트를 전달 받는다.
  const PostItem({Key? key, required this.listItems}) : super(key: key);

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {

  @override
  Widget build(BuildContext context) {
    final List<Widget> itemListData = widget.listItems.map((item) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailPost(id: item.id),
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
                                      item.title,
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
                                    item.content,
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
                                          '${item.created_at} | ${item.user_name}',
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
