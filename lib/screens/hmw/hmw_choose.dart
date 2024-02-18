import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/screens/hmw/widgets/check_design_paper.dart';
import 'package:inglo/screens/problem_definition/problem_write.dart';
import 'package:inglo/screens/problem_definition/widgets/design_card.dart';
import 'package:inglo/widgets/design_steps.dart';

class HMWChoosePage extends StatefulWidget {
  const HMWChoosePage({super.key});

  @override
  State<HMWChoosePage> createState() => _HMWChoosePageState();
}

class _HMWChoosePageState extends State<HMWChoosePage> {
  String checkedId = "0"; // 나중에 int로 바꾸기!

  // 더미데이터
  final List<Map<String, String>> problemList = [
    {"id": "1", "content": "choose 3-5 problems"},
    {
      "id": "2",
      "content":
          "Clean Energy Technological Innovation Reshapes the Future Energy Market"
    },
    {"id": "3", "content": "choose 3-5 problems"},
    {
      "id": "4",
      "content":
          "Clean Energy Technological Innovation Reshapes the Future Energy Market"
    },
    {"id": "5", "content": "choose 3-5 problems"},
    {
      "id": "6",
      "content":
          "Clean Energy Technological Innovation Reshapes the Future Energy Market"
    },
    {"id": "7", "content": "choose 3-5 problems"},
    {
      "id": "8",
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
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
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
                MasonryGridView.count(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: problemList.length,
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  itemBuilder: (context, index) {
                    return CheckDesignPaper(
                      id: problemList[index]["id"]!,
                      checkedId: checkedId,
                      checkCard: (id) {
                        setState(() {
                          if (checkedId == id) {
                            checkedId = "0";
                          } else {
                            checkedId = id;
                          }
                        });
                        print(id);
                        print(checkedId);
                      },
                      content: problemList[index]["content"]!,
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ElevatedButton(
          onPressed: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => const HMWListPage(),
            //     settings: RouteSettings(
            //       arguments: ModalRoute.of(context)!.settings.arguments,
            //     ),
            //   ),
            // );
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
