import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/models/comment/commnet.dart';
import 'package:dio/dio.dart';

import 'package:inglo/service/comment/comment_api.dart'; // api 호인스

// provider
import 'package:provider/provider.dart';
import 'package:inglo/provider/profile/users.dart';
import 'package:inglo/provider/user_token/user_token.dart';

class Comments extends StatefulWidget {
  final int id;

  // 생성자를 통해 id를 전달 받는다.
  const Comments({Key? key, required this.id}) : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final dio = Dio(); // dio instance 생성
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  final _parent_id = null; // 부모 피드백 아이디
  final _feedback_id = null;
  List<Comment> feedbacks = []; // feedback을 저장할 변수

  String? profile_img;

  final CommentService _CommentService = CommentService(); // instance 생성

  @override
  void dispose() {
    // 컨트롤러 해재
    commentController.dispose();
    super.dispose();
  }

  String? token ='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA4NTc3MDgwLCJpYXQiOjE3MDg0MzMwODAsImp0aSI6IjU1YWYyZjg2Y2I2NzQxOTFiMWQ5OWI0MjNhZmMxODEyIiwidXNlcl9pZCI6M30.ws5KsW_fBY-Kun1u3Rexkvnyjwz6_uN0PBqTnw7BKYs'; // token 저장

  // 초기 1번 실행 / 피드백 조회
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    profile_img = Provider.of<UserProvider>(context, listen: false).user?.profile_img ?? ''; // provider에서 토큰 가져오기
      loadFeedbacks(); // 비동기 함수 호출
    });
    print('token : $token');
  }

  Future<void> loadFeedbacks() async {
    try {
      // await 키워드를 사용하여 비동기 완료를 기다린다.
      List<Comment> feedbacks = await _CommentService.getFeedbacks(widget.id, token);
      setState(() {
        this.feedbacks = feedbacks;
      });
      print('데이터 받아옴 : ${feedbacks[0].user}');
    } catch (e) {
      // 오류 처리
      print("Error loading feedbacks: $e");
    }
  }

  void PostFeedback() {
    _CommentService.postFeedback(widget.id, commentController.text, _parent_id, token); // 피드백 제출
  }

  void ModifiedFeedback() {
    _CommentService.ModifiedFeedback(commentController.text, widget.id, _feedback_id, token); // 피드백 수정
  }

  void DeleteFeedback() {
    _CommentService.deleteFeedback(widget.id, _feedback_id, token); // 피드백 삭제
  }

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: CommentBox.commentImageParser(
                          imageURLorPath: data[i].user.profile_img)),
                ),
              ),
              title: Text(
                data[i].user.name,
                style: GoogleFonts.notoSans(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i].content),
              trailing: Text(data[i].created_at, style: GoogleFonts.notoSans(fontSize: 10)),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CommentBox(
          userImage: CommentBox.commentImageParser(
              imageURLorPath: profile_img),
          child: commentChild(feedbacks),
          labelText: 'Send Feedbacks',
          errorText: 'Comment cannot be blank',
          withBorder: false,
          sendButtonMethod: () async {
            if (formKey.currentState!.validate()) {
              PostFeedback();
              print(commentController.text);
              setState(() {});
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Color(0xFF233A66),
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}