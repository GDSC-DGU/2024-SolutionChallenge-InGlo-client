import 'package:flutter/material.dart';
import 'package:inglo/screens/post/detail_post.dart';
import 'package:google_fonts/google_fonts.dart';

// 더미데이터
final List<Map<String, String>> itemData = [
  {
    "title": "제목1 엄청나게 길 때에는 어떻게 되는걸까아아아아아ㅏㅇ아아아ㅏ아아아ㅏ",
    "content": "content 엄청나게 길 때에는 어떻게 되는걸까아아아아아ㅏ아아아아아아ㅏ앙",
    "image":
        "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"
  },
  {
    "title": "제목2",
    "content": "content",
    "image":
        "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"
  },
  {
    "title": "제목3",
    "content": "content",
    "image":
        "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"
  },
  {
    "title": "제목4",
    "content": "content",
    "image":
        "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"
  },
  {
    "title": "제목1",
    "content": "content",
    "image":
        "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"
  },
  {
    "title": "제목2",
    "content": "content",
    "image":
        "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"
  },
  {
    "title": "제목3",
    "content": "content",
    "image":
        "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"
  },
  {
    "title": "제목4",
    "content": "content",
    "image":
        "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"
  },
  {
    "title": "제목1",
    "content": "content",
    "image":
        "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"
  },
  {
    "title": "제목2",
    "content": "content",
    "image":
        "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"
  },
  {
    "title": "제목3",
    "content": "content",
    "image":
        "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"
  },
  {
    "title": "제목4",
    "content": "content",
    "image":
        "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"
  },
];

// 선
Widget buildDivider(BuildContext context) => Container(
      width: MediaQuery.of(context).size.width,
      child: Divider(),
    );

class PostItem extends StatelessWidget {
  const PostItem({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> itemListData = itemData.map((item) {
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
                                      item["title"]!,
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
                                        'assets/image/sdgs/sdgs1.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.cover, // container에 딱 맞게
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                  width: 200,
                                  child: Text(
                                    item["content"]!,
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
                                          '7분전 | 익명',
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
                                          "12",
                                          style: GoogleFonts.notoSans(
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Icon(
                                          Icons.visibility_outlined,
                                          color: Color(0xFFD7A859),
                                          size: 12.0,
                                        ),
                                        Text(
                                          "12",
                                          style: GoogleFonts.notoSans(
                                            fontSize: 12,
                                          ),
                                        ),
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
