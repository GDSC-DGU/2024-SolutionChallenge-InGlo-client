import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/provider/user_token/user_token.dart';
import 'package:inglo/screens/problem_definition/widgets/check_design_card.dart';
import 'package:inglo/service/design/problem_definition.dart';
import 'package:inglo/widgets/design/design_steps.dart';
import 'package:provider/provider.dart';

class ProblemChoosePage extends StatefulWidget {
  final int sdgs;
  const ProblemChoosePage({required this.sdgs, super.key});

  @override
  State<ProblemChoosePage> createState() => _ProblemChoosePageState();
}

class _ProblemChoosePageState extends State<ProblemChoosePage> {
  int checkedId = 0; // 선택한 아이디값 (선택안될 때는 0값)

  @override
  Widget build(BuildContext context) {
    final int sdgs = widget.sdgs;
    final token = context.watch<UserToken>().token;

    return Scaffold(
      backgroundColor: const Color(0xFFF7EEDE),
      // 상단 app 바로 뒤로가기 만들기!
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Choose problems",
          style: GoogleFonts.notoSans(
              color: const Color(0xFF233A66),
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: const Color(0xFFF7EEDE),
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
          padding: const EdgeInsets.fromLTRB(10, 0, 5, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DesignSteps(
                step: 1,
                sdgs: sdgs,
              ),
              FutureBuilder(
                future: ProblemDefinitionService()
                    .getProblemDefinition(sdgs, token),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasError) {
                      return const Center(child: Text('error')); // 에러 발생 시
                    } else {
                      var data = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: MasonryGridView.count(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          crossAxisCount: 2,
                          crossAxisSpacing: 1.0,
                          mainAxisSpacing: 1.0,
                          itemBuilder: (context, index) {
                            return CheckDesignCard(
                              id: data[index].id,
                              checkedId: checkedId,
                              checkCard: (id) {
                                setState(() {
                                  if (checkedId == id) {
                                    checkedId = 0;
                                  } else {
                                    checkedId = id;
                                  }
                                });
                              },
                              content: data[index].content,
                            );
                          },
                        ),
                      );
                    }
                  }
                },
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
            ProblemDefinitionService()
                .postProblemChoose(sdgs, checkedId, context, token);
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            side: const BorderSide(
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
