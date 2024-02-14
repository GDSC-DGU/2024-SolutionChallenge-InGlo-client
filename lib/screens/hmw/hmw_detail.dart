import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/screens/hmw/widgets/design_paper.dart';
import 'package:inglo/screens/problem_definition/problem_write.dart';
import 'package:inglo/screens/problem_definition/widgets/design_card.dart';
import 'package:inglo/widgets/design_steps.dart';

// 더미데이터
final List<Map<String, String>> problemList = [
  {"content": "choose 3-5 problems"},
  {
    "content":
        "Clean Energy Technological Innovation Reshapes the Future Energy Market"
  },
  {"content": "choose 3-5 problems"},
  {
    "content":
        "Clean Energy Technological Innovation Reshapes the Future Energy Market"
  },
  {"content": "choose 3-5 problems"},
  {
    "content":
        "Clean Energy Technological Innovation Reshapes the Future Energy Market"
  },
  {"content": "choose 3-5 problems"},
  {
    "content":
        "Clean Energy Technological Innovation Reshapes the Future Energy Market"
  },
];

class HMWDetailPage extends StatelessWidget {
  const HMWDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7EEDE),
      // 상단 app 바로 뒤로가기 만들기!
      appBar: AppBar(
        title: Text(
          "How Might We?",
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
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DesignSteps(step: 2),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 170,
                child: DesignCard(
                    content:
                        "Clean Energy Technological Innovation Reshapes the Future Energy Market"),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: problemList
                      .map(
                        (item) => DesignPaper(
                          content: item["content"]!,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ProblemWrite(),
              ),
            );
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
            'write',
            style: GoogleFonts.notoSans(
              color: Color(0xFF233A66),
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
