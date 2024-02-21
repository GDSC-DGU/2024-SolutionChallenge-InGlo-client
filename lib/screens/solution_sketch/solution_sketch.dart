import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inglo/provider/user_token/user_token.dart';
import 'package:inglo/screens/solution_sketch/widgets/solution_sketch_btn.dart';
import 'package:inglo/screens/solution_sketch/widgets/solution_sketch_img.dart';
import 'package:inglo/screens/solution_sketch/widgets/solution_sketch_input.dart';
import 'package:inglo/service/design/solution_sketch.dart';
import 'package:inglo/widgets/design/design_steps.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class SolutionSketchPage extends StatefulWidget {
  final int sdgs;
  final int problemId;
  const SolutionSketchPage({required this.sdgs, required this.problemId, super.key});

  @override
  State<SolutionSketchPage> createState() => _SolutionSketchPageState();
}

class _SolutionSketchPageState extends State<SolutionSketchPage> {
  String title = "";
  String description = "";
  String content = "";

  File? _image; //이미지를 담을 변수 선언
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화
  //이미지를 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = File(XFile(pickedFile.path)!.path); //가져온 이미지를 _image에 저장
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final int sdgs = widget.sdgs; // 받아온 sdgs값
    final int problemId = widget.problemId;
    final token = context.watch<UserToken>().token;

    return Scaffold(
      backgroundColor: Color(0xFFF7EEDE),
      // 상단 app 바로 뒤로가기 만들기!
      appBar: AppBar(
        title: Text(
          "Solution sketch",
          style: GoogleFonts.notoSans(
              color: Color(0xFF233A66),
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: Color(0xFFF7EEDE),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.help_outline,
              size: 25,
            ),
            tooltip: 'Show Snackbar', // icon 설명 tooltip
            onPressed: () {
              // 클릭하면 메시지를 띄운다.
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('설명 내용 넣기')));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DesignSteps(
                step: 4,
                sdgs: sdgs,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: SolutionSketchBtn(
                  getImage: getImage,
                  finishDrawing: (img) async{
                    var image = await writeToFile(img);
                    setState(() {
                      _image = image; //가져온 이미지를 _image에 저장
                    });
                  },
                ),
              ),
              if (_image != null)
                SolutionSketchImg(
                  imageData: _image,
                  deleteImage: () {
                    setState(() {
                      _image = null;
                    });
                  },
                ),
              SolutionSketchInput(
                changeTitle: (text) {
                  setState(() {
                    title = text;
                  });
                },
                changeDescription: (text) {
                  setState(() {
                    description = text;
                  });
                },
                changeContent: (text) {
                  setState(() {
                    content = text;
                  });
                },
              ),
              // Submit 버튼
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    SolutionSketchService().patchSolutionSketch(problemId, _image!, title, description, content, context, token);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    side: BorderSide(
                      color: Color(0xFF233A66),
                      width: 1,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  ),
                  child: Text(
                    'finish',
                    style: GoogleFonts.notoSans(
                      color: Color(0xFF233A66),
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ByteData를 File 형식으로 변경하는 함수!
  Future<File> writeToFile(ByteData data) async {
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = '$tempPath/file_01.tmp'; // file_01.tmp is dump file, can be anything

    return File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
