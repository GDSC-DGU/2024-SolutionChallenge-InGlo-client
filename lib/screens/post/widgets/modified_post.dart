import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:inglo/screens/post/detail_post.dart';
import 'package:inglo/screens/postlist/post_board.dart';
import 'package:inglo/service/post/post_api.dart';

// provider
import 'package:provider/provider.dart';
import 'package:inglo/provider/user_token/user_token.dart';

class ModifiedPost extends StatefulWidget {
  final int id;

  // 생성자를 통해 id를 전달 받는다.
  const ModifiedPost({Key? key, required this.id}) : super(key: key);

  @override
  _ModifiedPostState createState() => _ModifiedPostState();
}

class _ModifiedPostState extends State<ModifiedPost> {
  final dio = Dio(); // dio instance 생성
  String? token = ''; // token 저장

  // title 입력
  final TextEditingController _titleController = TextEditingController();
  final HtmlEditorController controller = HtmlEditorController();
  final PostService _PostService = PostService(); // instance 생성

  @override
  void dispose() {
    // 컨트롤러를 적절히 해제한다.
    _titleController.dispose();
    super.dispose();
  }

  // 초기 1번 실행
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      token = Provider.of<UserToken>(context, listen: false)
          .token; // provider에서 토큰 가져오기
    });
  }

  Future<void> modifiedPost() async {
    try {
      String text = await controller.getText();
      bool modified = await _PostService.ModifiedPost(
          _titleController.text, text, widget.id, token); // 피드백 수정
      if (modified == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PostBoardPage()),
        );
      } else {
        print('수정이 실패했습니다.');
      }
    } catch (e) {
      // 오류 처리
      print("Error loading new feedback: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPost(id: widget.id)),
            );
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xFF233A66)),
              onPressed: modifiedPost,
              child: Text(
                'Modified',
                style: GoogleFonts.notoSans(
                  fontSize: 16, // 폰트 크기 설정
                  fontWeight: FontWeight.bold, // 폰트 굵기 설정
                  color: Colors.white, // 텍스트 색상 설정
                ),
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          if (!kIsWeb) {
            controller.clearFocus();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                maxLines: null,
                maxLength: 50,
                // 사용자가 입력할 수 있는 최대 문자 수
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  hintStyle: GoogleFonts.notoSans(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  isDense: true,
                  counterText: "", // 문자 수 표시 없애기
                ),
                style: GoogleFonts.notoSans(
                    fontSize: 20, fontWeight: FontWeight.bold), // 내부 텍스트 스타일 지정
              ),
              HtmlEditor(
                controller: controller,
                htmlEditorOptions: HtmlEditorOptions(
                  shouldEnsureVisible: true,
                  //initialText: "<p>text content initial, if any</p>",
                ),
                htmlToolbarOptions: HtmlToolbarOptions(
                  defaultToolbarButtons: [
                    FontButtons(
                      clearAll: false,
                    ), // font style
                    StyleButtons(), // h1, h2...
                    InsertButtons(
                        audio: false,
                        video: false,
                        otherFile: false,
                        table: true,
                        hr: true),
                  ],
                  customToolbarButtons: [
                    // 커스텀 툴바
                  ],
                ),
                // 이외 사용자 옵션들
                otherOptions:
                    OtherOptions(height: MediaQuery.of(context).size.height),
                callbacks: Callbacks(
                  onBeforeCommand: (String? currentHtml) {
                    print('html before change is $currentHtml');
                  },
                  onChangeContent: (String? changed) {
                    print('content changed to $changed');
                  },
                  onChangeCodeview: (String? changed) {
                    print('code changed to $changed');
                  },
                  onChangeSelection: (EditorSettings settings) {
                    print('parent element is ${settings.parentElement}');
                    print('font name is ${settings.fontName}');
                  },
                  onEnter: () {
                    print('enter/return pressed');
                  },
                  onFocus: () {
                    print('editor focused');
                  },
                  onBlur: () {
                    print('editor unfocused');
                  },
                  onBlurCodeview: () {
                    print('codeview either focused or unfocused');
                  },
                  onInit: () {
                    print('init');
                  },
                  onImageUploadError:
                      (FileUpload? file, String? base64Str, UploadError error) {
                    print(describeEnum(error));
                    print(base64Str ?? '');
                    if (file != null) {
                      print(file.name);
                      print(file.size);
                      print(file.type);
                    }
                  },
                  onKeyDown: (int? keyCode) {
                    print('$keyCode key downed');
                    print(
                        'current character count: ${controller.characterCount}');
                  },
                  onKeyUp: (int? keyCode) {
                    print('$keyCode key released');
                  },
                  onMouseDown: () {
                    print('mouse downed');
                  },
                  onMouseUp: () {
                    print('mouse released');
                  },
                  onNavigationRequestMobile: (String url) {
                    print(url);
                    return NavigationActionPolicy.ALLOW;
                  },
                  onPaste: () {
                    print('pasted into editor');
                  },
                  onScroll: () {
                    print('editor scrolled');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
