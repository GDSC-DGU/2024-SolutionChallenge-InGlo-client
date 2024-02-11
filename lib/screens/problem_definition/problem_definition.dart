import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/widgets/design_steps.dart';

class ProblemDefinitionPage extends StatefulWidget {
  const ProblemDefinitionPage({super.key});

  @override
  State<ProblemDefinitionPage> createState() => _ProblemDefinitionPageState();
}

class _ProblemDefinitionPageState extends State<ProblemDefinitionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7EEDE),
      // 상단 app 바로 뒤로가기 만들기!
      appBar: AppBar(
        title: const Text(
          "Problem definition",
          style: TextStyle(
              color: Color(0xFF233A66),
              fontSize: 25,
              fontWeight: FontWeight.bold),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DesignSteps(step: 1),
          ],
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
                    fontSize: 18.0,
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
