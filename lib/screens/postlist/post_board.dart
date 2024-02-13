import 'package:flutter/material.dart';
import 'package:inglo/screens/post/create_post.dart';
import 'package:inglo/screens/postlist/widgets/dropdownbutton.dart';
import 'package:inglo/screens/postlist/widgets/newdropdownbutton.dart';
import 'package:inglo/screens/postlist/widgets/post_item.dart';


class PostBoardPage extends StatefulWidget {
  static const titleStyle = TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.w700);

  @override
  State<PostBoardPage> createState() => _PostBoardPageState();
}

class _PostBoardPageState extends State<PostBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: Stack( // Stack 위젯을 사용하여 겹치는 효과 구현
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70,
                    child: CustomDropdown(),
                  ),
                  Container(
                    child: const Text("Recents", style: PostBoardPage.titleStyle),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          PostItem(), // PostItem 호출
                          SizedBox(height: 0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned( // FloatingActionButton을 Positioned로 배치하여 위치 조정
                right: 0,
                bottom: 0,
                child: FloatingActionButton.extended(
                  heroTag: 'uniqueTag1', // 고유 태그
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreatePost(),
                      ),
                    );
                  },
                  backgroundColor: const Color(0xFF233A66),
                  label: const Icon(
                    Icons.post_add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
