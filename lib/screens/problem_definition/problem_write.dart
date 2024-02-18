import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/screens/problem_definition/widgets/write_card.dart';

class ProblemWrite extends StatefulWidget {
  const ProblemWrite({
    super.key,
  });

  @override
  State<ProblemWrite> createState() => _ProblemWriteState();
}

class _ProblemWriteState extends State<ProblemWrite> {


  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments; // 받아온 id값
    String content = ""; // 작성글 내용

    return Scaffold(
      backgroundColor: Color(0xFFF7EEDE),
      // 상단 app 바로 뒤로가기 만들기!
      appBar: AppBar(
        title: Text(
          "Write problems",
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 글쓰기
              WriteCard(
                id: id,
                changeContent: (text) {
                  setState(() {
                    content = text;
                  });
                },
              ),
              // Submit 버튼
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                    'submit',
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
