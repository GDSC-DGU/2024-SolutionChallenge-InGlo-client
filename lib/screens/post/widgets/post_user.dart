import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:inglo/models/post/detail_post.dart';

class PostUser extends StatelessWidget {
  final DetailPost detail;

  PostUser({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    child: Icon(
                      Icons.person_2_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  Text(
                    '${detail.user}',
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      color: Colors.black,),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '${detail.created_at}',
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
