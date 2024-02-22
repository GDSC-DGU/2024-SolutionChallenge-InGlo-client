import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/models/profile/user.dart';
import 'package:inglo/screens/profile/profile.dart';
import 'package:inglo/service/profile/profile.dart';
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

  ProfileService service = ProfileService(); //

  TextEditingController? _nameController;

  String? _country; // 국가
  String? _language; // 언어
  String? _profile_img; // 프로필 이미지 URL
  String? _name;

  User? user;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _name);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Provider에서 사용자 정보 가져오고, _nameController 업데이트
      token = Provider.of<UserToken>(context, listen: false).token;
      final user = Provider.of<UserProvider>(context, listen: false).user;
      _nameController?.text = user?.name ?? ''; // 컨트롤러의 텍스트 업데이트
      _profile_img = user?.profile_img ?? '';
      _language = user?.language ?? 'en';
      _country = (user?.country ?? '2').toString();
    });
  }

  @override
  void dispose() {
    _nameController?.dispose(); // 리소스 정리
    super.dispose();
  }

  // 이미지를 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path); // 가져온 이미지를 _image에 저장
      });
    }
  }

  void Cancel () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ProfilePage()), // 다음 페이지로 이동
    );
  }
  // 모두 post
  void PostAll() {
    if (_image != null) {
      service.UploadImage(_image, token, context);
      service.PostUserInfo(
          _nameController?.text, _country, _language, token, context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()), // 다음 페이지로 이동
      );
    } else {
      service.PostUserInfo(
          _nameController?.text, _country, _language, token, context);
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
                        initialValue: user?.name,
                        controller: _nameController,
                        decoration: InputDecoration(
                            hintText: 'name',
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 10,
                            )),
                        style: GoogleFonts.notoSans(fontSize: 14),
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
                                print('country 업데이트 ! $value');
                              } else {
                                // 기본 국가 메서드
                              }
                            });
                          },
                          initialValue: _country,
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 3),
                        child: Text("translate language",
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
                                print('language 업데이트 ! $value');
                              } else {
                                // 기본 언어 메서드
                              }
                            });
                          },
                          initialValue: _language,
                        ),
                      ),
                      SizedBox(height: 50.0),
                      // Login Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FilledButton(
                            onPressed: Cancel,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.white), // 버튼 배경색
                              minimumSize: MaterialStateProperty.all(
                                  Size(160, 40)), // 버튼 사이즈
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>( // 버튼의 모양과 경계선을 정의
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100), // 둥근 모서리의 반지름
                                  side: BorderSide(color: Color(0xFFFFD691), width: 2), // 경계선의 색상과 두께
                                ),
                              ),
                            ),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.notoSans(
                                  fontSize: 20,
                                  color: Color(0xFFFFD691),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          FilledButton(
                            onPressed: PostAll,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color(0xFFFFD691)), // 버튼 배경색
                              minimumSize: MaterialStateProperty.all(
                                  Size(160, 40)), // 버튼 사이즈
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
