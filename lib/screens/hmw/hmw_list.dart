import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/screens/crazy/crazy_8s.dart';
import 'package:inglo/screens/hmw/widgets/multiple_design_card.dart';
import 'package:inglo/screens/problem_definition/problem_choose.dart';
import 'package:inglo/screens/problem_definition/problem_write.dart';
import 'package:inglo/screens/problem_definition/widgets/design_card.dart';
import 'package:inglo/widgets/design_steps.dart';

class HMWListPage extends StatefulWidget {
  const HMWListPage({super.key});

  @override
  State<HMWListPage> createState() => _HMWListPageState();
}

class _HMWListPageState extends State<HMWListPage> {
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
    final sdgs = ModalRoute.of(context)!.settings.arguments; // 받아온 sdgs값

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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DesignSteps(step: 2),
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
                      // return DesignCard(content: problemList[index - 1]["content"]!);
                      return MultipleDesignCard(content: problemList[index - 1]["content"]!);
                    }
                  },
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
                builder: (context) => const Crazy8sPage(),
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
