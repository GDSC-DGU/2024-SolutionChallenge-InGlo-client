import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inglo/screens/post/widgets/image_slider.dart';
import 'package:inglo/screens/post/widgets/post_user.dart';
import 'package:inglo/widgets/modal/barmodal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:inglo/models/post/detail_post.dart'; // model
import 'package:inglo/util/post/detailpost.dart'; // util

class DetailPost extends StatefulWidget {
  @override
  _DetailPostState createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {
  final detail = DetailPostPreferences.detailPost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.pop(context); // 이전 페이지로 이동
                          },
                        ),
                        Spacer(),
                        Column(
                          children: [
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                // 좋아요 기능 구현
                              },
                              child: Icon(
                                detail.is_liked
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: Color(0xFFFF6280),
                                size: 20.0,
                              ),
                            ),
                            SizedBox(height: 0), // 여기서 간격을 조절
                            Text(
                              '${detail.likes}',
                              style: GoogleFonts.notoSans(
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          detail.title,
                          style: GoogleFonts.notoSans(
                            fontSize: 26, // 폰트 크기 설정
                            fontWeight: FontWeight.bold, // 폰트 굵기 설정
                            color: Colors.black, // 텍스트 색상 설정
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                          child: PostUser(detail: detail),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.6, // 컨텐츠 영역을 화면의 60%로 설정
                          child: WebView(
                            initialUrl: 'about:blank',
                            onWebViewCreated:
                                (WebViewController webViewController) {
                              // 웹뷰가 생성되면 HTML 내용을 로드 한다.
                              webViewController.loadUrl(Uri.dataFromString(
                                detail.content, // HTML 내용을 가져오는 함수
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
                    height: 40,
                    child: BarModal(),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
