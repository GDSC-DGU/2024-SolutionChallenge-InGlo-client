import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/screens/issue_detail/widgets/issue_comment.dart';
import 'package:inglo/screens/issue_detail/widgets/issue_content.dart';
import 'package:inglo/screens/issue_detail/widgets/issue_input.dart';

class IssueDetailPage extends StatelessWidget {
  const IssueDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      colorFilter:
                          ColorFilter.mode(Colors.black54, BlendMode.darken),
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fitWidth,
                      image: AssetImage('assets/image/sdgs1.png'),
                    ),
                  ),
                  child: SafeArea(
                    //backgroundColor: Colors.transparent,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.bookmark,
                                      size: 30,
                                      color: Color(0xFFFF6280),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "2024.01.01",
                                    style: GoogleFonts.notoSans(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Title~~~~",
                                    style: GoogleFonts.notoSans(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "#description~~",
                                    style: GoogleFonts.notoSans(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: IssueContent(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          IssueComment(),
        ],
      ),
      bottomSheet: IssueInput(),
    );
  }
}
