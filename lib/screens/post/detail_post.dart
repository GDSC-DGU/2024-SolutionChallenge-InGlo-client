import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inglo/screens/post/widgets/image_slider.dart';
import 'package:inglo/screens/post/widgets/post_user.dart';
import 'package:inglo/widgets/modal/barmodal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
                        Text(
                          'Title',
                          style: GoogleFonts.notoSans(
                            fontSize: 20, // 폰트 크기 설정
                            fontWeight: FontWeight.bold, // 폰트 굵기 설정
                            color: Colors.black, // 텍스트 색상 설정
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          child: PostUser(),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6, // 컨텐츠 영역을 화면의 60%로 설정
                          child: WebView(
                            initialUrl: 'about:blank',
                            onWebViewCreated: (WebViewController webViewController) {
                              // 웹뷰가 생성되면 HTML 내용을 로드 한다.
                              webViewController.loadUrl(Uri.dataFromString(
                                _getHtmlContent(), // HTML 내용을 가져오는 함수
                                mimeType: 'text/html',
                                encoding: utf8,
                              ).toString());
                            },
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 더미 데이터로부터 HTML 컨텐츠를 반환하는 함수
String _getHtmlContent() {
  return '''
      <!DOCTYPE html>
      <html>
      <head>
        <title>Example Post</title>
        <style>
          body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            font-size: 16px;
            color: #333;
          }
          h1 {
            font-size: 26px;
            font-weight: bold;
            color: #000;
          }
          p {
            margin: 10px 0;
          }
          img {
            max-width: 100%;
            height: auto;
          }
        </style>
      </head>
      <body>
        <h1>This is the title of the post</h1>
        <p>This is a paragraph describing the content of the post. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget risus eget massa semper consectetur eu nec leo. Praesent tempus vel libero vel suscipit. Integer mattis nunc non feugiat venenatis.</p>
        <img src="https://via.placeholder.com/600" alt="Example Image">
        <p>This is another paragraph. Nullam fermentum, quam sit amet fermentum vehicula, enim nunc bibendum odio, vel rhoncus lorem ex eu velit.</p>
      </body>
      </html>
    ''';
}