import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/models/my_drawing/my_drawing_model.dart';

class DetailSketch4Content extends StatelessWidget {
  final MyDrawingDetailModel data;
  const DetailSketch4Content({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: const Color(0xFFFFD691),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: GoogleFonts.notoSans(fontSize: 15, color: Colors.black38),
          // border 스타일
          filled: true,
          fillColor: const Color(0xFFFFD691),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xFF233A66), // 테두리 색상
              width: 1.0, // 테두리 두께
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xFF233A66), // 테두리 색상
              width: 1.0, // 테두리 두께
            ),
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Text(
                  "title",
                  style:
                      GoogleFonts.notoSans(fontSize: 15, color: Colors.black),
                ),
              ),
              TextFormField(
                initialValue: data.title,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: 'write the title...',
                  contentPadding: EdgeInsets.all(8), // padding
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Text(
                  "description",
                  style:
                  GoogleFonts.notoSans(fontSize: 15, color: Colors.black),
                ),
              ),
              TextFormField(
                initialValue: data.description,
                readOnly: true,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'write the description...',
                  contentPadding: EdgeInsets.all(8), // padding
                ),
                maxLines: null, // 자동 줄 바꿈
                minLines: 2,
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Text(
                  "content",
                  style:
                  GoogleFonts.notoSans(fontSize: 15, color: Colors.black),
                ),
              ),
              TextFormField(
                initialValue: data.content,
                readOnly: true,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'write solution sketch...',
                  contentPadding: EdgeInsets.all(8), // padding
                ),
                maxLines: null, // 자동 줄 바꿈
                minLines: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
