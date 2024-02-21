import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/screens/issuelist/issulist.dart';
import 'package:dio/dio.dart';

import 'package:provider/provider.dart';
import 'package:inglo/provider/user_token/user_token.dart';

class GetProfilePage extends StatefulWidget {
  const GetProfilePage({Key? key}) : super(key: key);

  @override
  State<GetProfilePage> createState() => _GetProfilePageState();
}

class _GetProfilePageState extends State<GetProfilePage> {
  XFile? _image; //이미지를 담을 변수 선언
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화
  final dio = Dio();

  String? token; // token 저장

  // 초기 1번 실행
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      token = Provider.of<UserToken>(context, listen: false).token; // provider에서 토큰 가져오기
    });
  }

  // 이미지를 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path); // 가져온 이미지를 _image에 저장
      });
      uploadImage(); // 이미지를 서버에 전송하는 함수 호출
    }
  }

  // 이미지를 서버에 전송하는 함수
  Future<void> uploadImage() async {
    if (_image == null) return;
    String fileName = _image!.path.split('/').last;

    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(_image!.path, filename: fileName),
      });

      dio.options.headers = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token', // 필요한 토큰이나 인증 정보를 여기에 추가
      };

      var response = await dio.patch(
        'https://dongkyeom.com/api/v1/accounts/info/profile-img/',
        data: formData,
      );

      print('업로드 성공 : ${response.statusCode}');

      // 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => IssueListPage()), // 다음 페이지로 이동
      );

    } catch (e) {
      print('이미지 업로드 실패: $e');
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
                onPressed: uploadImage,
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
