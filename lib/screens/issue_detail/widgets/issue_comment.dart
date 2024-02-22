import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IssueComment extends StatelessWidget {
  const IssueComment({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 0.15,
      initialChildSize: 0.3,
      builder: (context, scrollController) => SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        controller: scrollController,
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          decoration: const BoxDecoration(
            color: Color(0xFFF7EEDE),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xFFD7A859),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "6 comments",
                style: GoogleFonts.notoSans(
                  color: Color(0xFFD7A859),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 원형 이미지
                    const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80")),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFD7A859),
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "writer's name",
                              style: GoogleFonts.notoSans(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Clean Energy Technological Innovation Reshapes the Future Energy Market",
                              style: GoogleFonts.notoSans(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
