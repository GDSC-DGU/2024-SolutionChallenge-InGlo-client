import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inglo/provider/profile/users.dart';
import 'package:inglo/screens/post/widgets/modified_post.dart';
import 'package:inglo/screens/post/widgets/post_user.dart';
import 'package:inglo/screens/postlist/post_board.dart';
import 'package:inglo/service/post/post_api.dart';
import 'package:inglo/service/post/post_detail_api.dart';
import 'package:inglo/widgets/modal/barmodal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart' as webview_flutter;
import 'package:dio/dio.dart';

// provider
import 'package:provider/provider.dart';
import 'package:inglo/provider/user_token/user_token.dart';

class DetailPost extends StatefulWidget {
  final int id;

  // 생성자를 통해 id를 전달 받는다.
  const DetailPost({Key? key, required this.id}) : super(key: key);

  @override
  _DetailPostState createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {
  bool isEditing = false; // edit 상태 관리
  bool isLoading = true; // 로딩 상태 관리
  bool isLiked = false;
  Map<String, dynamic>? detailPost; // api 저장용
  final dio = Dio(); // dio instance 생성
  // final detail = DetailPostPreferences.detailPost;

  String? token = ''; // token 저장
  int? id = 0;

  final PostService _PostService = PostService(); // instance 생성

  // 초기 1번 실행
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      token = Provider.of<UserToken>(context, listen: false)
          .token; // provider에서 토큰 가져오기
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      id = userProvider.user?.id ?? 0; // id
      await getDetail();
    });
    setState(() {
      isEditing = false;
    });
  }

  onClickLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  // profile get 함수
  Future<void> getDetail() async {
    print('id : ${widget.id}');
    print('token : $token');
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
            'Authorization': 'Bearer $token',
          },
        ),
      );

      String responseBody = response.data;
      final jsonResponse =
          jsonDecode(responseBody); // 문자열을 파싱하여 dart 객체로 변환시킨다.

      print('ID: ${jsonResponse['id']}');
      print('User: ${jsonResponse['user']['name']}');
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
          print('post : ${detailPost!['feedbacks']}'); // null 검사 후 값에 접근
        }
      });

      // final detail = DetailPost.fromJson(jsonResponse); // 왜인지 안 된다!
    } catch (e) {
      // 요청 실패 또는 기타 에러 처리
      print('Error fetching data: $e');
    }
  }

  Future<void> DeletePost() async {
    await _PostService.deletePost(widget.id, token, context); // 포스트 삭제
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Center(
                child: Text('로딩 중입니다... '),
              )
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
                            child: AppBar(
                              leading: IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PostBoardPage()),
                                  );
                                },
                              ),
                              title: Text(""),
                              actions: [
                                isEditing
                                    ? Container()
                                    : Row(
                                        children: [
                                          Text(
                                            '${detailPost?['likes'] ?? '0'}',
                                            style: GoogleFonts.notoSans(
                                              fontSize: 14,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              PostDetailService().postIssueLike(
                                                  detailPost!['id'] ?? 0,
                                                  onClickLike,
                                                  token);
                                            },
                                            icon: Icon(
                                              isLiked
                                                  ? Icons.favorite
                                                  : Icons
                                                      .favorite_border_outlined,
                                              size: 30,
                                              color: Color(0xFFFF6280),
                                            ),
                                          ),
                                          detailPost?['user']['id'] == id
                                              ? PopupMenuButton(
                                                  color: Color(0xFFFFD691),
                                                  offset: Offset(0, 60),
                                                  onSelected: (String result) {
                                                    print(result);
                                                    if (result == 'modified') {
                                                      setState(() {
                                                        isEditing = !isEditing;
                                                      });
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ModifiedPost(
                                                                  id: widget
                                                                      .id), // id 값을 전달
                                                        ),
                                                      );
                                                    } else if (result ==
                                                        'delete') {
                                                      DeletePost();
                                                    }
                                                  },
                                                  itemBuilder: (BuildContext
                                                          context) =>
                                                      <PopupMenuEntry<String>>[
                                                    PopupMenuItem<String>(
                                                      value: 'modified',
                                                      child:
                                                          _buildPopupMenuItem(
                                                              'modified',
                                                              Icons.edit),
                                                    ),
                                                    PopupMenuItem<String>(
                                                      value: 'delete',
                                                      child:
                                                          _buildPopupMenuItem(
                                                              'delete',
                                                              Icons.delete),
                                                    ),
                                                  ],
                                                )
                                              : Container()
                                        ],
                                      ),
                              ],
                              backgroundColor: Colors.white,
                              // AppBar 배경색, 필요에 따라 조정
                              elevation: 0, // AppBar 음영 제거, 필요에 따라 조정
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          isEditing
                              ? Container()
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${detailPost?['title'] ?? 'none'}',
                                        style: GoogleFonts.notoSans(
                                          fontSize: 26, // 폰트 크기 설정
                                          fontWeight:
                                              FontWeight.bold, // 폰트 굵기 설정
                                          color: Colors.black, // 텍스트 색상 설정
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 20,
                                        child: PostUser(
                                          user_profile_img: detailPost?['user']
                                              ['profile_img'],
                                          user_name: detailPost?['user']['name']
                                              as String?,
                                          created_at: detailPost?['created_at']
                                              as String?,
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.6, // 컨텐츠 영역을 화면의 60%로 설정
                                        child: webview_flutter.WebView(
                                          initialUrl: 'about:blank',
                                          onWebViewCreated:
                                              (webview_flutter.WebViewController
                                                  webViewController) {
                                            // 웹뷰가 생성되면 HTML 내용을 로드 한다.
                                            webViewController
                                                .loadUrl(Uri.dataFromString(
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
        ${detailPost?['content'] ?? '<h1>not found content</h1>'}
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
                          child: isEditing
                              ? Container()
                              : BarModal(id: widget.id, sketch_id: detailPost?['sketch']['id'],)),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

PopupMenuItem _buildPopupMenuItem(String title, IconData iconData) {
  return PopupMenuItem(
    value: title, // 선택 시 onSeleted에 전달
    child: Row(
      children: [
        Icon(
          iconData,
          color: Colors.black,
        ),
        Text(title),
      ],
    ),
  );
}
