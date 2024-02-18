import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/screens/issuelist/sdgs_select.dart';

class IssueContent extends StatelessWidget {
  const IssueContent({super.key});

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
              "The world is currently witnessing a significant focus on clean energy technologies. Recent studies indicate a rapid development in renewable energy sources such as solar, wind, and geothermal energy.Numerous countries are implementing policies to support this transition and investment in clean energy technologies is on the rise. Experts predict that these changes will bring long-term economic and environmental benefits....",
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
