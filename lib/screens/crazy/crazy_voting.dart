import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/screens/crazy/crazy_voting.dart';
import 'package:inglo/screens/crazy/widgets/crazy_pagination.dart';
import 'package:inglo/screens/problem_definition/problem_write.dart';
import 'package:inglo/screens/problem_definition/widgets/design_card.dart';
import 'package:inglo/widgets/design/design_steps.dart';

class CrazyVotingPage extends StatefulWidget {
  const CrazyVotingPage({super.key});

  @override
  State<CrazyVotingPage> createState() => _CrazyVotingPageState();
}

class _CrazyVotingPageState extends State<CrazyVotingPage> {
  // 더미데이터
  final problemList = [
    {
      "id": "2",
      "contents": [
        {"id": "1", "content": "1choose 3-5 problems"},
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
      ],
    },
    {
      "id": "5",
      "contents": [
        {"id": "1", "content": "2choose 3-5 problems"},
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
      ],
    },
    {
      "id": "6",
      "contents": [
        {"id": "1", "content": "3choose 3-5 problems"},
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
      ],
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
          "Crazy Voting",
          style: GoogleFonts.notoSans(
              color: Color(0xFF233A66),
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: Color(0xFFF7EEDE),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 5, 3),
            child: Text(
              "2/3",
              style: GoogleFonts.notoSans(
                color: Color(0xFFFF6280),
                fontSize: 15,
                letterSpacing: 4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                side: BorderSide(
                  color: Color(0xFF233A66),
                  width: 1,
                ),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
              ),
              child: Text(
                'next',
                style: GoogleFonts.notoSans(
                  color: Color(0xFF233A66),
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
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
              CrazyPagination(
                problemList: problemList,
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              //   child: MasonryGridView.count(
              //     physics: BouncingScrollPhysics(),
              //     shrinkWrap: true,
              //     itemCount: problemList.length,
              //     crossAxisCount: 2,
              //     crossAxisSpacing: 5.0,
              //     mainAxisSpacing: 5.0,
              //     itemBuilder: (context, index) {
              //       return DesignCard(
              //           content: problemList[index]["content"]!);
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
