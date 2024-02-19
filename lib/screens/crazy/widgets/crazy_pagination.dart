import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/screens/problem_definition/widgets/check_design_card.dart';
import 'package:pager/pager.dart';

class CrazyPagination extends StatefulWidget {
  final problemList;

  const CrazyPagination({
    required this.problemList,
    Key? key,
  }) : super(key: key);

  @override
  State<CrazyPagination> createState() => _CrazyPaginationState();
}

class _CrazyPaginationState extends State<CrazyPagination> {
  late int _currentPage;
  late String checkedId;

  @override
  void initState() {
    super.initState();
    _currentPage = 1;
    checkedId = "0";// 나중에 int로 바꾸기!
  }

  @override
  Widget build(BuildContext context) {
    final problemList = widget.problemList; // 초기화

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: MasonryGridView.count(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: problemList[_currentPage - 1]["contents"].length,
              crossAxisCount: 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              itemBuilder: (context, index) {
                return CheckDesignCard(
                  id: problemList[_currentPage - 1]["contents"][index]["id"]!,
                  checkedId: checkedId,
                  checkCard: (id) {
                    setState(() {
                      if(checkedId == id) {
                        checkedId = "0";
                      } else {
                        checkedId = id;
                      }
                    });
                    print(id);
                    print(checkedId);
                  },
                  content: problemList[_currentPage - 1]["contents"][index]["content"]!,);
              },
            ),
          ),
          // Container(
          //   height: 200,
          //   margin: const EdgeInsets.all(32),
          //   color: Colors.blue,
          //   child: Center(
          //     child: Text(
          //       "PAGE: $_currentPage",
          //       style: GoogleFonts.notoSans(color: Colors.white, fontSize: 20),
          //     ),
          //   ),
          // ),
          Pager(
            currentPage: _currentPage,
            totalPages: problemList.length,
            numberButtonSelectedColor: Color(0xFF233A66),
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
            },
          ),
        ],
      ),
    );
  }
}
