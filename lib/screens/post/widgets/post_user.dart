import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:inglo/models/post/detail_post.dart';

class PostUser extends StatelessWidget {
  final String? user_name;
  final String? created_at;
  final user_profile_img;

  const PostUser({
    Key? key,
    this.user_name,
    this.created_at,
    this.user_profile_img,
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
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(100),
                    ),
                    child: ClipRRect(
                      // ClipRRect를 사용하여 이미지도 borderRadius를 적용
                      borderRadius:
                      BorderRadius.circular(100),
                      child: Image.network(
                        user_profile_img ?? '',
                        width: 12,
                        height: 12,
                        fit: BoxFit
                            .cover, // container에 딱 맞게
                      ),
                    ),
                  ),
                  SizedBox(width: 8,),
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
