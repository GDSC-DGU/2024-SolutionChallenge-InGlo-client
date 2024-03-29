import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:inglo/models/design/crazy.dart';
import 'package:inglo/provider/user_token/user_token.dart';
import 'package:inglo/screens/crazy/widgets/check_design_cards.dart';
import 'package:inglo/service/design/crazy_service.dart';
import 'package:pager/pager.dart';
import 'package:provider/provider.dart';

class CrazyPagination extends StatefulWidget {
  final List<CrazyAllModel> problemList;
  final List checkedNumber;
  final int problemId;
  final changeCheckedNumber;

  const CrazyPagination({
    required this.problemList,
    required this.checkedNumber,
    required this.problemId,
    required this.changeCheckedNumber,
    Key? key,
  }) : super(key: key);

  @override
  State<CrazyPagination> createState() => _CrazyPaginationState();
}

class _CrazyPaginationState extends State<CrazyPagination> {
  late int _currentPage;
  //late int checkedId;

  @override
  void initState() {
    super.initState();
    _currentPage = 1;
    //checkedId = 0; // 나중에 int로 바꾸기!
  }

  @override
  Widget build(BuildContext context) {
    final List<CrazyAllModel> problemList = widget.problemList; // 초기화
    final checkedNumber = widget.checkedNumber;
    final problemId = widget.problemId;
    final changeCheckedNumber = widget.changeCheckedNumber;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: MasonryGridView.count(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: problemList[_currentPage - 1].contents.length,
              crossAxisCount: 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              itemBuilder: (context, index) {
                return CheckDesignCards(
                  id: problemList[_currentPage - 1].contents[index]["id"],
                  voteNumber : problemList[_currentPage - 1].contents[index]["vote_count"],
                  content: problemList[_currentPage - 1].contents[index]
                      ["content"],
                  checkCard: (id, isChecked, changeIsChecked) {
                    if (!isChecked) {
                      if (checkedNumber.length == 3) {
                        return showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: ((context) {
                            return AlertDialog(
                              title: const Text("Crazy 8's Choose"),
                              content: const Text("Please Choose 1~3 Crazy 8's."),
                              actions: <Widget>[
                                Container(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); //창 닫기
                                    },
                                    child: Text("Confirm"),
                                  ),
                                ),
                              ],
                            );
                          }),
                        );
                      }
                    }
                    setState(() {
                      if (!isChecked) {
                        changeCheckedNumber(0, id);
                      } else {
                        changeCheckedNumber(1, id);
                      }
                    });
                    changeIsChecked();

                    print(id);
                  },
                );
              },
            ),
          ),
          Pager(
            currentPage: _currentPage,
            totalPages: problemList.length,
            numberButtonSelectedColor: const Color(0xFF233A66),
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
