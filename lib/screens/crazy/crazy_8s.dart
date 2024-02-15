import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/screens/crazy/crazy_voting.dart';
import 'package:inglo/screens/problem_definition/problem_write.dart';
import 'package:inglo/screens/problem_definition/widgets/design_card.dart';
import 'package:inglo/widgets/design_steps.dart';

class Crazy8sPage extends StatefulWidget {
  const Crazy8sPage({super.key});

  @override
  State<Crazy8sPage> createState() => _Crazy8sPageState();
}

class _Crazy8sPageState extends State<Crazy8sPage> {
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
          "Crazy 8's",
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
          padding: EdgeInsets.fromLTRB(10, 0, 10, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DesignSteps(step: 3),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: MasonryGridView.count(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: problemList.length + 1,
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        margin: EdgeInsets.all(40),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ProblemWrite(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            //fixedSize: Size(30, 30),
                            backgroundColor: Colors.white,
                            shape: CircleBorder(),
                            // padding도 넣을 수 있음!
                            padding: EdgeInsets.all(10.0),
                            side: BorderSide(
                              color: Color(0xFF233A66),
                              width: 1,
                            ),
                            shadowColor: Colors.transparent,
                          ),
                          child: const Icon(
                            Icons.edit_outlined,
                            size: 25,
                            color: Color(0xFF233A66),
                          ),
                        ),
                      );
                    } else {
                      return DesignCard(content: problemList[index - 1]["content"]!);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked, // 버튼 가운데 정렬
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              // 최대한 가로 길이 늘리기
              child: FloatingActionButton.extended(
                onPressed: () {
                  // Add your onPressed code here!
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CrazyVotingPage(),
                    ),
                  );
                },
                backgroundColor: Colors.white,
                shape: StadiumBorder(
                  side: BorderSide(
                    color: Color(0xFF233A66),
                    width: 1,
                  ),
                ),
                label: Text(
                  "Let's vote!",
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
    );
  }
}
