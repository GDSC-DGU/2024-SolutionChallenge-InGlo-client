import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/provider/user_token/user_token.dart';
import 'package:inglo/screens/crazy/widgets/crazy_pagination.dart';
import 'package:inglo/screens/solution_sketch/solution_sketch.dart';
import 'package:inglo/service/design/crazy_service.dart';
import 'package:inglo/widgets/design/design_steps.dart';
import 'package:provider/provider.dart';

class CrazyVotingPage extends StatefulWidget {
  final int sdgs;
  final int problemId;
  const CrazyVotingPage({required this.sdgs, required this.problemId, super.key});

  @override
  State<CrazyVotingPage> createState() => _CrazyVotingPageState();
}

class _CrazyVotingPageState extends State<CrazyVotingPage> {
  late List checkedNumber;

  @override
  void initState() {
    super.initState();
    checkedNumber = [];
  }

  @override
  Widget build(BuildContext context) {
    final int sdgs = widget.sdgs; // 받아온 sdgs값
    final int problemId = widget.problemId;
    final token = context.watch<UserToken>().token;

    return Scaffold(
      backgroundColor: Color(0xFFF7EEDE),
      // 상단 app 바로 뒤로가기 만들기!
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 25,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
              "${checkedNumber.length}/3",
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
              onPressed: () async {
                if(checkedNumber.isEmpty) {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: ((context) {
                      return AlertDialog(
                        title: Text("Crazy 8's Choose"),
                        content: Text("Please Choose one Crazy 8's."),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(); //창 닫기
                            },
                            child: Text("Confirm"),
                          ),
                        ],
                      );
                    }),
                  );
                } else {
                  print(checkedNumber);
                  await Future.forEach(checkedNumber, (item) {
                    print("call : $item");
                    CrazyService().postCrazyChoose(problemId, item, context, token);
                  });
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          SolutionSketchPage(sdgs: sdgs, problemId: problemId,),
                    ),
                  );
                }

              },
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
              DesignSteps(step: 3, sdgs: sdgs,),
              FutureBuilder(
                future: CrazyService().getCrazyAll(problemId, token),
                builder: (context, snapshot) {
                  var data = snapshot.data!;
                  return CrazyPagination(
                  problemList: data,
                  problemId: problemId,
                  checkedNumber: checkedNumber,
                  changeCheckedNumber : (int type, int id) {
                    setState(() {
                      if(type != 0) {
                        checkedNumber.remove(id);
                      } else {
                        checkedNumber.add(id);
                      }
                    });
                    print(checkedNumber);
                  }
                ); },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
