import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/provider/user_token/user_token.dart';
import 'package:inglo/screens/crazy/crazy_voting.dart';
import 'package:inglo/screens/crazy/crazy_write.dart';
import 'package:inglo/screens/hmw/widgets/design_paper.dart';
import 'package:inglo/screens/problem_definition/widgets/design_card.dart';
import 'package:inglo/service/design/crazy_service.dart';
import 'package:inglo/service/translate/translate_util.dart';
import 'package:inglo/widgets/design/design_steps.dart';
import 'package:provider/provider.dart';

class Crazy8sPage extends StatefulWidget {
  final int sdgs;
  final int problemId;
  const Crazy8sPage({required this.sdgs, required this.problemId, super.key});

  @override
  State<Crazy8sPage> createState() => _Crazy8sPageState();
}

class _Crazy8sPageState extends State<Crazy8sPage> {
  @override
  Widget build(BuildContext context) {
    final int sdgs = widget.sdgs;
    final int problemId = widget.problemId;
    final token = context.watch<UserToken>().token;

    return Scaffold(
      backgroundColor: Color(0xFFF7EEDE),
      // 상단 app 바로 뒤로가기 만들기!
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 50),
            child: FutureBuilder(
              future: CrazyService().getCrazyMine(problemId, token),
              builder: (context, snapshot) {
                var data = snapshot.data!;

                if(data != null)  { return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DesignSteps(
                      step: 3,
                      sdgs: sdgs,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (data.hmwContent != null)
                      FutureBuilder(
                        future: TranslationService()
                            .getTranslation(data.hmwContent, context),
                        builder: (context, snapshot) {
                          var transData = snapshot.data!;
                          if(transData != null) {
                            return SizedBox(
                              width: 170,
                              child: DesignCard(
                                content: transData,
                              ),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    MasonryGridView.count(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.crazy8stack.length + 1,
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
                                    builder: (context) => CrazyWrite(
                                      sdgs: sdgs,
                                      problemId: problemId,
                                    ),
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
                          return DesignPaper(
                              content: data.crazy8stack[index - 1]["content"] ?? "");
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ); } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked, // 버튼 가운데 정렬
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              // 최대한 가로 길이 늘리기
              child: FloatingActionButton.extended(
                onPressed: () {
                  //Add your onPressed code here!
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CrazyVotingPage(
                        sdgs: sdgs,
                        problemId: problemId,
                      ),
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
