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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.search,
            color: Color(0xFFD7A859),
            size: 30.0,
          ),
        ],
      ),
    );
  }
}
