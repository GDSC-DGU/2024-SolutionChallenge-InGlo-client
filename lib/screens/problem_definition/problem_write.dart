import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/provider/user_token/user_token.dart';
import 'package:inglo/service/design/problem_definition.dart';
import 'package:inglo/widgets/design/write_card.dart';
import 'package:provider/provider.dart';

class ProblemWrite extends StatefulWidget {
  final int sdgs;
  const ProblemWrite({
    required this.sdgs,
    super.key,
  });

  @override
  State<ProblemWrite> createState() => _ProblemWriteState();
}

class _ProblemWriteState extends State<ProblemWrite> {
  String content = "";

  @override
  Widget build(BuildContext context) {
    final int sdgs = widget.sdgs;
    final token = context.watch<UserToken>().token;

    return Scaffold(
      backgroundColor: Color(0xFFF7EEDE),
      // 상단 app 바로 뒤로가기 만들기!
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 25,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                changeContent: (text) {
                  setState(() {
                    content = text;
                  });
                  print('${content}, ${text}');
                },
              ),
              // Submit 버튼
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: ElevatedButton(
                  onPressed: () {
                    print(content);
                    ProblemDefinitionService().postProblemDefinition(sdgs, content, context, token);
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
