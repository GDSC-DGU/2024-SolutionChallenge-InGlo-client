import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/models/profile/user.dart';
import 'package:inglo/screens/profile/profile.dart';
import 'package:inglo/util/profile/user_preferences.dart';
import 'package:inglo/widgets/appbar/appbar.dart';
import 'package:inglo/widgets/profile/numbers_widget.dart';
import 'package:dio/dio.dart';
import 'package:inglo/widgets/dropdown/intdropdown.dart';
import 'package:inglo/widgets/dropdown/stringdropdown.dart';
import 'package:inglo/util/options/country_data.dart';
import 'package:inglo/util/options/language_data.dart';

// provider
import 'package:provider/provider.dart';
import 'package:inglo/provider/profile/users.dart';
import 'package:inglo/provider/user_token/user_token.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SetProfilePage extends StatefulWidget {
  @override
  _SetProfilePageState createState() => _SetProfilePageState();
}

class _SetProfilePageState extends State<SetProfilePage> {
  final dio = Dio(); // dio instance 생성
  String? token = ''; // token 빈 값으로 우선 정의

  XFile? _image; //이미지를 담을 변수 선언
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화

  // 초기 1번 실행
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      token = Provider.of<UserToken>(context, listen: false)
          .token; // provider에서 토큰 가져오기
    });
  }

  String _name = ''; // 사용자 이름 저장을 위한 변수
  int _country = 2; // 국가 저장을 위한 변수
  String _language = ''; // 언어 저장을 위한 변수

  // 전체 update 함수
  void updateSpecificUserInfo(BuildContext context, User newUser) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    userProvider.updateUser(newUser);
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
        MaterialPageRoute(builder: (context) => ProfilePage()), // 프로필 페이지로 이동
      );
    } catch (e) {
      print('이미지 업로드 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFFF7EEDE),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context); // 이전 페이지로 이동
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0xFFF7EEDE),
          child: Center(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    _buildPhotoArea(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildButton(),
                    SizedBox(
                      height: 30,
                    ),
                    buildAbout(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAbout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.525,
            color: Colors.white, // 상자 색
            child: Theme(
              data: ThemeData(
                primaryColor: Color(0xFFFFD691),
                inputDecorationTheme: InputDecorationTheme(
                  labelStyle: GoogleFonts.notoSans(
                      color: Color(0xFFFFD691),
                      fontSize: 47.0,
                      fontWeight: FontWeight.w700),
                  // border 스타일
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Color(0xFFC4C4C4), // 테두리 색상
                      width: 1.0, // 테두리 두께
                    ),
                  ),
                  // 포커스 시 스타일
                  focusedBorder: OutlineInputBorder(
                    // 포커스를 받았을 때의 테두리 스타일
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Color(0xFFFFD691), // 포커스 받았을 때의 테두리 색상
                      width: 2.0, // 포커스 받았을 때의 테두리 두께
                    ),
                  ),
                ),
              ),
              child: Form(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
                  child: Column(
                    // crossAxis : 수평축을 따라 자식들을 어떻게 배치할 지
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxis : column 수직축을 따라 자식 위젯들을 어떻게 배치할 지
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(11, 0, 0, 5),
                        child: Text("name",
                            style: GoogleFonts.notoSans(
                              color: Colors.black,
                            )),
                      ),
                      TextFormField(
                        initialValue: '은지',
                        decoration: InputDecoration(
                            hintText: 'name',
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 10,
                            )),
                        style: GoogleFonts.notoSans(fontSize: 14),
                        onChanged: (value) {
                          setState(() {
                            _name = value; // 사용자 입력에 따라 _name 변수의 값을 변경
                          });
                        },
                      ),
                      SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 3),
                        child: Text("country",
                            style: GoogleFonts.notoSans(
                              color: Colors.black,
                            )),
                      ),
                      SizedBox(
                        height: 45.0,
                        child: IntBorderCustomDropdown(
                          options: countryData,
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                _country = value; // _country는 널이 아닐 때만 업데이트
                              } else {
                                // 기본 국가 메서드
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 3),
                        child: Text("language",
                            style: GoogleFonts.notoSans(
                              color: Colors.black,
                            )),
                      ),
                      SizedBox(
                        height: 45.0,
                        child: BorderCustomDropdown(
                          options: languageData,
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                _language = value; // _country는 널이 아닐 때만 업데이트
                              } else {
                                // 기본 언어 메서드
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 50.0),
                      // Login Button
                      FilledButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color(0xFFFFD691)), // 버튼 배경색
                          minimumSize: MaterialStateProperty.all(
                              Size(400, 40)), // 버튼 사이즈
                        ),
                        child: Text(
                          "SAVE",
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
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoArea() {
    return _image != null
        ? Container(
            width: 200,
            height: 200,
            child: ClipOval(
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.file(File(_image!.path), fit: BoxFit.cover),
              ),
            ),
          )
        : Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Color(0xFFFFD691),
              borderRadius: BorderRadius.circular(200),
              border: Border.all(color: Colors.white, width: 5),
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
