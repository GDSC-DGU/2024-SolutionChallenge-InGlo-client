import 'package:flutter/material.dart';

class IssueSearch extends StatefulWidget {
  const IssueSearch({super.key});

  @override
  State<IssueSearch> createState() => _IssueSearchState();
}

class _IssueSearchState extends State<IssueSearch> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("검색 버튼"),
        ],
      ),
    );
  }
}
