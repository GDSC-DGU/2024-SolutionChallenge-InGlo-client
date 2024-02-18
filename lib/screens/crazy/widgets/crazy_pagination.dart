import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pager/pager.dart';

class CrazyPagination extends StatefulWidget {
  const CrazyPagination({
    Key? key,
  }) : super(key: key);

  @override
  State<CrazyPagination> createState() => _CrazyPaginationState();
}

class _CrazyPaginationState extends State<CrazyPagination> {
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            margin: const EdgeInsets.all(32),
            color: Colors.blue,
            child: Center(
              child: Text(
                "PAGE: $_currentPage",
                style: GoogleFonts.notoSans(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Pager(
            currentPage: _currentPage,
            totalPages: 5,
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
