import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/models/issue/comment.dart';
import 'package:dio/dio.dart';
import 'package:inglo/models/issue/modified_comment.dart';

import 'package:inglo/service/comment/issue_comment_api.dart'; // api 호인스

// provider
import 'package:provider/provider.dart';
import 'package:inglo/provider/profile/users.dart';
import 'package:inglo/provider/user_token/user_token.dart';
import 'package:intl/intl.dart';

class IssueComments extends StatefulWidget {
  final int id;

  // 생성자를 통해 id를 전달 받는다.
  const IssueComments({Key? key, required this.id}) : super(key: key);

  @override
  _IssueCommentsState createState() => _IssueCommentsState();
}

class _IssueCommentsState extends State<IssueComments> {
  final dio = Dio(); // dio instance 생성
  final formKey = GlobalKey<FormState>();
  int? _parent_id = null; // 부모 피드백 아이디
  int? _comment_id = null; // 현재 선택한 feedback id
  List<IssueComment> comments = []; // feedback을 저장할 변수
  IssueModifiedComment? newComment;

  int? isEditing; // edit 모드 저장 변수
  String? _modifiedController = '';

  final TextEditingController commentController = TextEditingController();
  final TextEditingController modifiedController =
  TextEditingController(); // 수정용

  final IssueCommentService _IssueCommentService = IssueCommentService(); // instance 생성

  @override
  void dispose() {
    // 컨트롤러 해재
    commentController.dispose();
    super.dispose();
  }

  String? token = ''; // token 저장
  String? profile_img = UserProvider().user?.profile_img ?? '';
  String? user_name = UserProvider().user?.name ?? '';

  // 초기 1번 실행 / 피드백 조회
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      token = Provider.of<UserToken>(context, listen: false).token;
      await loadComments(); // 비동기 함수 호출
    });
    print('token : $token');
  }

  Future<void> loadComments() async {
    try {
      // await 키워드를 사용하여 비동기 완료를 기다린다.
      List<IssueComment> feedbacks =
      await _IssueCommentService.getComments(widget.id, token);
      setState(() {
        this.comments = feedbacks;
      });
      print('데이터 받아옴 : ${feedbacks[0].user}');
    } catch (e) {
      // 오류 처리
      print("Error loading feedbacks: $e");
    }
  }

  Future<void> modifiedComment() async {
    print('수정 시작');
    try {
      print('수정 완료');
      // await 키워드를 사용하여 비동기 완료를 기다린다.
      IssueModifiedComment newComment = await _IssueCommentService.ModifiedComments(
          modifiedController.text, widget.id, _comment_id, token); // 피드백 수정
      setState(() {
        this.newComment = newComment;
      });
      print('데이터 받아왔ㄸ따따다ㅏ다다다다ㅏㄷ다ㅏㄷ : $newComment');
    } catch (e) {
      // 오류 처리
      print("Error loading new feedback: $e");
    }
  }

  Future<void> PostComment() async {
    await _IssueCommentService.postComment(
        widget.id, commentController.text, _parent_id, token); // 피드백 제출
  }

  Future<void> modifiedContent() async {
    try {
      // await 키워드를 사용하여 비동기 완료를 기다린다.
      IssueModifiedComment newComment = await _IssueCommentService.ModifiedComments(
          modifiedController.text, widget.id, _comment_id, token); // 피드백 수정
    } catch (e) {
      // 오류 처리
      print("Error loading new feedback: $e");
    }
  }

  Future<void> DeleteComment() async {
    await _IssueCommentService.deleteComment(
        widget.id, _comment_id, token); // 피드백 삭제
  }

  Widget commentChild(data, id) {
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
              // edit 모드인 경우 text editor으로 전환한다.
              subtitle: isEditing == i
                  ? Form(
                child: TextFormField(
                  controller: modifiedController,
                  decoration: InputDecoration(
                    isDense: true, // 여백 최소화
                  ),
                  style: GoogleFonts.notoSans(fontSize: 14),
                  // 수정 완료 후 수정 api
                  onFieldSubmitted: (value) {
                    setState(() {
                      isEditing = null;
                    });
                    modifiedComment();
                    modifiedController.clear(); // 컨트롤러 초기화
                    FocusScope.of(context).unfocus(); // 키보드 숨기기
                  },
                ),
              )
                  : Text(data[i].content),
              trailing: Container(
                width: 60,
                child: Column(
                  children: [
                    data[i].user.id != id // 유저 아이디가 같지 않다면
                        ? Container()
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            print("Edit Clicked");
                            setState(() {
                              if (isEditing == i) {
                                isEditing = null;
                              } else {
                                isEditing = i; // 수정 모드로 전환
                                _comment_id =
                                    data[i].id; // feedback id도 변경
                                modifiedController.text = data[i].content;
                              }
                            });
                            if (isEditing == null) {
                              await modifiedComment();
                              modifiedController.clear(); // 컨트롤러 초기화
                              FocusScope.of(context).unfocus(); // 키보드 숨기기
                              await loadComments();
                            }
                          },
                          child: Icon(
                            isEditing == i ? Icons.send : Icons.edit,
                            color: Color(0xFFD7A859),
                            size: 25,
                          ),
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () async {
                            print("Delete Clicked");
                            _comment_id = data[i].id;
                            await DeleteComment();
                            await loadComments();
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.grey,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                    Text(
                        DateFormat('yyyy-MM-dd')
                            .format(DateTime.parse(data[i].created_at)),
                        style: GoogleFonts.notoSans(fontSize: 10)),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final profile_img = userProvider.user?.profile_img; // img
    final id = userProvider.user?.id; // id

    return Scaffold(
      body: Container(
        child: CommentBox(
          userImage: CommentBox.commentImageParser(imageURLorPath: profile_img),
          child: commentChild(comments, id),
          labelText: 'Send Comments',
          errorText: 'Comment cannot be blank',
          withBorder: false,
          sendButtonMethod: () async {
            if (formKey.currentState!.validate()) {
              await PostComment();
              await loadComments();
              print(commentController.text);
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Color(0xFFFFD691),
          textColor: Colors.black,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.black),
        ),
      ),
    );
  }
}