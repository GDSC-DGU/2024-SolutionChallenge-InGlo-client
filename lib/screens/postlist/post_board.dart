import 'package:flutter/material.dart';
import 'package:inglo/screens/post/create_post.dart';
import 'package:inglo/screens/post/widgets/selected_sketch.dart';
import 'package:inglo/widgets/appbar/appbar.dart';
import 'package:inglo/widgets/dropdown/dropdownbutton.dart';
import 'package:inglo/screens/issuelist/widgets/issue_choose.dart';
import 'package:inglo/screens/postlist/widgets/post_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/service/auth/user/user_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:convert';

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:inglo/models/post/post_list.dart';

// provider
import 'package:provider/provider.dart';
import 'package:inglo/provider/user_token/user_token.dart';


class PostBoardPage extends StatefulWidget {
  @override
  State<PostBoardPage> createState() => _PostBoardPageState();
}

class _PostBoardPageState extends State<PostBoardPage> {
  static final storage = FlutterSecureStorage(); // secure storage 호출
  int sdgs = 1; // 1~17?

  final dio = Dio(); // dio instance 생성
  final List<PostList> _listItems = [];
  String? token = ''; // token 저장
  String? refresh_token = '';

  // 초기 1번 실행
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
   token = Provider.of<UserToken>(context, listen: false).token; // provider에서 토큰 가져오기
   refresh_token = await storage.read(key:'refresh_token'); // refresh token
    await getPostItems(); // API 호출
    });
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
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if(response.statusCode == 200 || response.statusCode == 201) {
        print('성공!');
        final List<dynamic> jsonResponse = jsonDecode(response.data);
        print('data : ${jsonResponse}');

        setState(() {
          _listItems.clear(); // 기존 목록을 지우고 새로운 데이터로 채운다.
          for (var item in jsonResponse) {
            _listItems.add(PostList.fromJson(item));
          }
        });
      } else if(response.statusCode == 401) {
        // refresh로 access Update
         UserAuthService().GetNewToken(refresh_token, (newToken) {
          Provider.of<UserToken>(context, listen: false).setToken(newToken);
        }, context);
      }
    } catch (e) {
      // 요청 실패 또는 기타 에러 처리
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
          child: Stack(
            // Stack 위젯을 사용하여 겹치는 효과 구현
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IssueMenu(
                      selectedSdgs: sdgs,
                      onSdgsTap: (int sdgs) {
                        setState(() {
                          this.sdgs = sdgs;
                        });
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      "Recents",
                      style: GoogleFonts.notoSans(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          PostItem(listItems : _listItems), // PostItem 호출
                          SizedBox(height: 0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                // FloatingActionButton을 Positioned로 배치하여 위치 조정
                right: 0,
                bottom: 0,
                child: FloatingActionButton.extended(
                  heroTag: 'uniqueTag1', // 고유 태그
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SelectedSketch(),
                      ),
                    );
                  },
                  backgroundColor: const Color(0xFF233A66),
                  label: const Icon(
                    Icons.post_add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationAppBar(
        currentIndex: 2, // index 전송
      ),
    );
  }
}
