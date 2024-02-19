import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final dio = Dio(); // dio instance 생성

  // controller
  final HtmlEditorController controller = HtmlEditorController();
  TextEditingController textEditingController = TextEditingController();

  String _title = '';
  String _content = '';
  String _image = '';
  int _sketch_id = 0;
  int _sdgs = 0;

  // post 생성 api
  Future<void> _handlePost() async {
    final url = "https://dongkyeom.com/api/v1/accounts/info/";
    Map<String, dynamic> data = {
      "title": _title,
      "content": _content,
      "image": _image,
      "sketch_id": int.parse('$_sketch_id'),
      "sdgs": int.parse('$_sdgs'),
    };

    // 요청 헤더 설정
    Options options = Options(
      contentType: Headers.jsonContentType,
      headers: {
        "Authorization":
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA4MzY4MTQ3LCJpYXQiOjE3MDgzNjQ1NDcsImp0aSI6IjYyNzRjY2RjZjY1MzQ4NjU5NjYzOTQxZjVmMDMwNDc2IiwidXNlcl9pZCI6M30._-R-VopbH5kIv9YkbMGuARcOF9z4E2TwQiy0kq-d6Uw',
      },
    );

    try {
      final response = await dio.post(url, data: data, options: options);

      if (response.statusCode == 200) {
        // 성공
        print(
            'Success code: ${response.statusCode}, response: ${response.data}');

        /*
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GetProfilePage()), // 다음 페이지로 이동
        );
*/
      } else {
        // 비-200 상태 코드
        print('Error code: ${response.statusCode}, response: ${response.data}');
      }
    } catch (e) {
      // 예외 처리
      print('Exception caught: $e');
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
            Navigator.pop(context); // 이전 페이지로 이동
          },
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF233A66)),
            onPressed: _handlePost,
            child: Text('Post',
              style: GoogleFonts.notoSans(
                fontSize: 16, // 폰트 크기 설정
                fontWeight: FontWeight.bold, // 폰트 굵기 설정
                color: Colors.white, // 텍스트 색상 설정
              ),),
          )
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
                maxLines: null,
                maxLength: 50, // 사용자가 입력할 수 있는 최대 문자 수
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  hintStyle: GoogleFonts.notoSans(fontSize: 20, fontWeight: FontWeight.bold),
                  isDense: true,
                  counterText: "", // 문자 수 표시 없애기
                ),
                style: GoogleFonts.notoSans(fontSize: 20, fontWeight: FontWeight.bold), // 내부 텍스트 스타일 지정
              ),
              HtmlEditor(
                controller: controller,
                htmlEditorOptions: HtmlEditorOptions(
                  shouldEnsureVisible: true,
                  //initialText: "<p>text content initial, if any</p>",
                ),
                htmlToolbarOptions: HtmlToolbarOptions(
                  defaultToolbarButtons: [
                    FontButtons(clearAll: false,), // font style
                    StyleButtons(), // h1, h2...
                    InsertButtons(audio: false, video: false, otherFile: false, table: true, hr: true),
                  ],
                  customToolbarButtons: [
                    // 커스텀 툴바
                  ],
                ),
                // 이외 사용자 옵션들
                otherOptions: OtherOptions(height: MediaQuery.of(context).size.height),
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
                  onImageUploadError: (FileUpload? file, String? base64Str, UploadError error) {
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
                    print('current character count: ${controller.characterCount}');
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
