import 'package:flutter/material.dart';
import 'package:inglo/screens/issuelist/widgets/issue_search.dart';
import 'package:inglo/screens/issuelist/widgets/issue_slider.dart';

class IssueListPage extends StatefulWidget {
  // 나중에 폰트 스타일 다시 재정의!
  static const titleStyle =
      TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w700);

  @override
  State<IssueListPage> createState() => _IssueListPageState();
}

class _IssueListPageState extends State<IssueListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IssueSearch(),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: const Text("Recommand", style: IssueListPage.titleStyle),
              ),
              IssueSlider(),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: const Text("Today's Issue",
                    style: IssueListPage.titleStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
