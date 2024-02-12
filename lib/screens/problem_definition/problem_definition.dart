import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/screens/problem_definition/problem_write.dart';
import 'package:inglo/screens/problem_definition/widgets/design_card.dart';
import 'package:inglo/widgets/design_steps.dart';

class ProblemDefinitionPage extends StatefulWidget {
  const ProblemDefinitionPage({super.key});

  @override
  State<ProblemDefinitionPage> createState() => _ProblemDefinitionPageState();
}

class _ProblemDefinitionPageState extends State<ProblemDefinitionPage> {
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
          "Problem definition",
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
          padding: EdgeInsets.fromLTRB(10, 0, 10, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DesignSteps(step: 1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: problemList.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ProblemWrite(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            //maximumSize: Size(30, 30),
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
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const SDGSSelectPage(),
                  //   ),
                  // );
                },
                backgroundColor: Colors.white,
                shape: StadiumBorder(
                  side: BorderSide(
                    color: Color(0xFF233A66),
                    width: 1,
                  ),
                ),
                label: Text(
                  'choose 3-5 problems',
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
