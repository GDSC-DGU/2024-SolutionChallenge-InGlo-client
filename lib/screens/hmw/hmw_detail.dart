import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/provider/user_token/user_token.dart';
import 'package:inglo/screens/hmw/hmw_choose.dart';
import 'package:inglo/screens/hmw/hmw_write.dart';
import 'package:inglo/screens/hmw/widgets/design_paper.dart';
import 'package:inglo/screens/problem_definition/widgets/design_card.dart';
import 'package:inglo/service/design/hmw_service.dart';
import 'package:inglo/service/translate/translate_util.dart';
import 'package:inglo/widgets/design/design_steps.dart';
import 'package:provider/provider.dart';

class HMWDetailPage extends StatefulWidget {
  final int sdgs;
  final int problemId;
  const HMWDetailPage({required this.sdgs, required this.problemId, super.key});

  @override
  State<HMWDetailPage> createState() => _HMWDetailPageState();
}

class _HMWDetailPageState extends State<HMWDetailPage> {
  @override
  Widget build(BuildContext context) {
    final int sdgs = widget.sdgs;
    final int problemId = widget.problemId;
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
          child: FutureBuilder(
            future: HMWService().getHmw(problemId, token),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasError) {
                  return const Center(child: Text('error')); // 에러 발생 시
                } else {
                  var data = snapshot.data!;
                  return Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DesignSteps(
                          step: 2,
                          sdgs: sdgs,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (data.problemContent != null)
                          FutureBuilder(
                            future: TranslationService()
                                .getTranslation(data.problemContent, context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(child: Text("loading..."));
                              } else {
                                if (snapshot.hasError) {
                                  return const Center(
                                      child: Text('error')); // 에러 발생 시
                                } else {
                                  var transData = snapshot.data!;
                                  return SizedBox(
                                    width: 170,
                                    child: DesignCard(content: transData),
                                  );
                                }
                              }
                            },
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        MasonryGridView.count(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.hmws.length + 1,
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Container(
                                margin: const EdgeInsets.all(40),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => HMWWrite(
                                          sdgs: sdgs,
                                          problemId: problemId,
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: const CircleBorder(),
                                    // padding도 넣을 수 있음!
                                    padding: const EdgeInsets.all(10.0),
                                    side: const BorderSide(
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
                                  content:
                                      data.hmws[index - 1]["content"] ?? "");
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                }
              }
            },
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
                      builder: (context) => HMWChoosePage(
                        sdgs: sdgs,
                        problemId: problemId,
                      ),
                    ),
                  );
                },
                backgroundColor: Colors.white,
                shape: const StadiumBorder(
                  side: BorderSide(
                    color: Color(0xFF233A66),
                    width: 1,
                  ),
                ),
                label: Text(
                  'choose one HMW',
                  style: GoogleFonts.notoSans(
                    color: const Color(0xFF233A66),
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
