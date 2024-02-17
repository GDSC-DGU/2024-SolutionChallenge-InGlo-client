import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/screens/issuelist/issulist.dart';

class GetProfilePage extends StatefulWidget {
  const GetProfilePage({Key? key}) : super(key: key);

  @override
  State<GetProfilePage> createState() => _GetProfilePageState();
}

class _GetProfilePageState extends State<GetProfilePage> {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 30,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // title만 중앙 정렬, 나머지는 flex-start
              Center(
                child: Text(
                  "UPLOAD PROFILE IMAGE",
                  style: GoogleFonts.notoSans(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(height: 30, width: double.infinity),
              _buildPhotoArea(),
              SizedBox(height: 10),
              _buildButton(),
              SizedBox(height: 40),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => IssueListPage()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFFFFD691)),
                  // 버튼 배경색
                  minimumSize:
                      MaterialStateProperty.all(Size(400, 40)), // 버튼 사이즈
                ),
                child: Text(
                  "FINISH",
                  style: GoogleFonts.notoSans(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoArea() {
    return _image != null
        ? Container(
            width: 300,
            height: 300,
            child: ClipOval(
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.file(File(_image!.path), fit: BoxFit.cover),
              ),
            ),
          )
        : Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Color(0xFFF7EEDE),
              borderRadius: BorderRadius.circular(200),
              border: Border.all(color: Color(0xFFF7EEDE), width: 2),
            ),
          );
  }

  Widget _buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilledButton(
          onPressed: () {
            getImage(ImageSource.camera); //getImage 함수를 호출해서 카메라로 찍은 사진 가져오기
          },
          child: Icon(
            Icons.camera_alt,
            color: Color(0xFFFFD691),
          ),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: Color(0xFFFFD691), width: 2),
            ),
          ),
        ),
        SizedBox(width: 20),
        FilledButton(
          onPressed: () {
            getImage(ImageSource.gallery); //getImage 함수를 호출해서 갤러리에서 사진 가져오기
          },
          child: Icon(Icons.photo_album),
          style: FilledButton.styleFrom(
            backgroundColor: Color(0xFFFFD691),
            padding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: Color(0xFFFFD691), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
