import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/provider/user_token/user_token.dart';
import 'package:inglo/screens/hmw/widgets/check_design_paper.dart';
import 'package:inglo/screens/problem_definition/widgets/design_card.dart';
import 'package:inglo/service/design/hmw_service.dart';
import 'package:inglo/widgets/design/design_steps.dart';
import 'package:provider/provider.dart';

class HMWChoosePage extends StatefulWidget {
  final int problemId;
  final int sdgs;
  const HMWChoosePage({required this.problemId, required this.sdgs, super.key});

  @override
  State<HMWChoosePage> createState() => _HMWChoosePageState();
}

class _HMWChoosePageState extends State<HMWChoosePage> {
  int checkedId = 0;

  @override
  Widget build(BuildContext context) {
    final int problemId = widget.problemId;
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
          "How Might We?",
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
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 50),
            child: FutureBuilder(
              future: HMWService().getHmw(problemId, token),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text("loading..."));
                } else {
                  if (snapshot.hasError) {
                    return const Center(child: Text('error')); // 에러 발생 시
                  } else {
                    var data = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DesignSteps(
                          step: 2,
                          sdgs: sdgs,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 170,
                          child: DesignCard(content: data.problemContent),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MasonryGridView.count(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.hmws.length,
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                          itemBuilder: (context, index) {
                            return CheckDesignPaper(
                              id: data.hmws[index]["id"],
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
                              content: data.hmws[index]["content"],
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  }
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ElevatedButton(
          onPressed: () {
            HMWService().patchHMW(sdgs, problemId, checkedId, context, token);
          },
          style: ElevatedButton.styleFrom(
            elevation: 0,
            side: const BorderSide(
              color: Color(0xFF233A66),
              width: 1,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          ),
          child: Text(
            'next',
            style: GoogleFonts.notoSans(
              color: const Color(0xFF233A66),
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
