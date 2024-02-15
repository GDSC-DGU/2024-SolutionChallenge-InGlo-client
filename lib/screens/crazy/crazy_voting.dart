import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/screens/hmw/hmw_list.dart';
import 'package:inglo/screens/problem_definition/widgets/check_design_card.dart';
import 'package:inglo/widgets/design_steps.dart';

class CrazyVotingPage extends StatefulWidget {
  const CrazyVotingPage({super.key});

  @override
  State<CrazyVotingPage> createState() => _CrazyVotingPageState();
}

class _CrazyVotingPageState extends State<CrazyVotingPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7EEDE),
      // 상단 app 바로 뒤로가기 만들기!
      appBar: AppBar(
        title: Text(
          "Crazy voting",
          style: GoogleFonts.notoSans(
              color: Color(0xFF233A66),
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: Color(0xFFF7EEDE),
        actions: <Widget>[
          Row(
            children: [
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
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 10, 3),
                child: Text(
                  "2/3",
                  style: GoogleFonts.notoSans(
                    color: Color(0xFFFF6280),
                    fontSize: 15,
                    letterSpacing: 4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(10, 0, 5, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DesignSteps(step: 3),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: MasonryGridView.count(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: problemList.length,
                  crossAxisCount: 2,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                  itemBuilder: (context, index) {
                    return CheckDesignCard(
                        content: problemList[index]["content"]!);
                  },
                ),
              ),
              // Submit 버튼
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
                builder: (context) => const HMWListPage(),
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
            'next',
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
