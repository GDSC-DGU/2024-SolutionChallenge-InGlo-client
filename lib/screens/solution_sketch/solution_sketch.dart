import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inglo/screens/solution_sketch/widgets/solution_sketch_btn.dart';
import 'package:inglo/screens/solution_sketch/widgets/solution_sketch_img.dart';
import 'package:inglo/screens/solution_sketch/widgets/solution_sketch_input.dart';
import 'package:inglo/widgets/design/design_steps.dart';

class SolutionSketchPage extends StatefulWidget {
  final int sdgs;
  const SolutionSketchPage({required this.sdgs, super.key});

  @override
  State<SolutionSketchPage> createState() => _SolutionSketchPageState();
}

class _SolutionSketchPageState extends State<SolutionSketchPage> {
  XFile? _image; //이미지를 담을 변수 선언
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화
  //이미지를 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
    }
  }

  // 더미데이터
  // final drawingData = [
  //   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  // ];


  @override
  Widget build(BuildContext context) {
    final int sdgs = widget.sdgs;// 받아온 sdgs값

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
              DesignSteps(step: 4, sdgs: sdgs,),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: SolutionSketchBtn(getImage: getImage),
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
              SolutionSketchInput(),
              // Submit 버튼
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {},
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
}
