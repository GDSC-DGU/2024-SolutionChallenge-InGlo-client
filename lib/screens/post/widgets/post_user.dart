import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:inglo/models/post/detail_post.dart';

class PostUser extends StatelessWidget {
  final String? user_name;
  final String? created_at;

  const PostUser({
    Key? key,
    this.user_name,
    this.created_at,
  }) : super(key: key);

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
                    user_name ?? 'Unknown',
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      color: Colors.black,),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    created_at ?? '0000.00.00',
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
