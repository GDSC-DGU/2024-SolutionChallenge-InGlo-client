import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/screens/issuelist/sdgs_select.dart';

class IssueContent extends StatelessWidget {
  final data;
  const IssueContent({required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Text(
              data.content,
              style: GoogleFonts.notoSans(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: -40,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color(0xFFD7A859)),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SDGSSelectPage(),
                  ),
                );
              },
              child: Text(
                "Let's Design",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
