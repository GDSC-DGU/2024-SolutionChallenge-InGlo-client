import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inglo/screens/post/widgets/image_slider.dart';
import 'package:inglo/screens/post/widgets/post_user.dart';
import 'package:inglo/widgets/modal/barmodal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:inglo/util/post/detailpost.dart'; // util
import 'dart:convert';

import 'package:dio/dio.dart';

class DetailPost extends StatefulWidget {
  final int id;

  // 생성자를 통해 id를 전달 받는다.
  const DetailPost({Key? key, required this.id}) : super(key: key);

  @override
  _DetailPostState createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {
  bool isLoading = true; // 로딩 상태 관리
  Map<String, dynamic>? detailPost; // api 저장용
  final dio = Dio(); // dio instance 생성
  // final detail = DetailPostPreferences.detailPost;

  // 초기 1번 실행
  void initState() {
    super.initState();
    getDetail();
  }

  // profile get 함수
  Future<void> getDetail() async {

    setState(() {
      isLoading = true; // 데이터 요청 전 로딩 상태로 설정
    });

    final url = "https://dongkyeom.com/api/v1/posts/${widget.id}";

    try {
      final response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA4NTc3MDgwLCJpYXQiOjE3MDg0MzMwODAsImp0aSI6IjU1YWYyZjg2Y2I2NzQxOTFiMWQ5OWI0MjNhZmMxODEyIiwidXNlcl9pZCI6M30.ws5KsW_fBY-Kun1u3Rexkvnyjwz6_uN0PBqTnw7BKYs',
          },
        ),
      );

      String responseBody = response.data;
      final jsonResponse =
          jsonDecode(responseBody); // 문자열을 파싱하여 dart 객체로 변환시킨다.

      print('ID: ${jsonResponse['id']}');
      print('User: ${jsonResponse['user']}');
      print('Sketch: ${jsonResponse['sketch']}');
      print('Title: ${jsonResponse['title']}');
      print('Content: ${jsonResponse['content']}');
      print('SDGs: ${jsonResponse['sdgs']}');
      print('Likes: ${jsonResponse['likes']}');
      print('Created At: ${jsonResponse['created_at']}');
      print('Feedbacks: ${jsonResponse['feedbacks']}');
      print('Is Liked: ${jsonResponse['is_liked']}');

      setState(() {
        isLoading = false; // 데이터를 받아온 후 로딩 상태 해제
        detailPost = jsonResponse;
        if (detailPost != null) {
          print('post : ${detailPost!['id']}'); // null 검사 후 값에 접근
        }
      });

      // final detail = DetailPost.fromJson(jsonResponse); // 왜인지 안 된다!
    } catch (e) {
      // 요청 실패 또는 기타 에러 처리
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
          ? Center(child: Text('로딩 중입니다... '),)
          : Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                                  detailPost != null &&
                                          detailPost!['is_liked'] == true
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: Color(0xFFFF6280),
                                  size: 20.0,
                                ),
                              ),
                              SizedBox(height: 0), // 여기서 간격을 조절
                              Text(
                                '${detailPost?['likes'] ?? '0'}',
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
                            '${detailPost?['title'] ?? 'none'}',
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
                            child: PostUser(
                              user_name: detailPost?['user_name'] as String?,
                              created_at: detailPost?['created_at'] as String?,
                            ),
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
                                  '''
      <!DOCTYPE html>
      <html>
      <head>
        <title>Example Post</title>
        <style>
          body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            font-size: 24px;
            color: #333;
          }
          h1 {
            font-size: 32px;
            font-weight: bold;
            color: #000;
          }
          p {
            margin: 10px 0;
          }
          img {
            max-width: 50%;
            height: auto;
          }
        </style>
      </head>
      <body>
      <div>
        ${detailPost?['content'] ?? '<p>not found content</p>'}
        </div>
      </body>
      </html>
    ''', // HTML 내용을 가져오는 함수
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
                left: 20,
                right: 20,
                child: SizedBox(
                  height: 40,
                  child: BarModal(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
