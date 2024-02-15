import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inglo/models/profile/user.dart';
import 'package:inglo/screens/profile/widgets/my_posts.dart';
import 'package:inglo/screens/profile/widgets/my_sketch.dart';
import 'package:inglo/screens/profile/widgets/select_langauge.dart';
import 'package:inglo/util/profile/user_preferences.dart';
import 'package:inglo/widgets/profile/numbers_widget.dart';
import 'package:inglo/widgets/profile/profile_widget.dart';
import 'package:inglo/widgets/profile/button_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      body: Container(
        color: Color(0xFFF7EEDE),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 24),
            ProfileWidget(
              imagePath: user.imagePath,
            ),
            const SizedBox(height: 24),
            buildName(user),
            const SizedBox(height: 10),
            NumbersWidget(),
            const SizedBox(height: 20),
            buildAbout(user),
          ],
        ),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ],
      );

  Widget buildAbout(User user) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                color: Colors.white, // 상자 색
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    ButtonWidget(
                      text: 'My Sketchs',
                      color: 'D55382',
                      bg: 'EDD2DB',
                      icon1: Icons.draw,
                      icon2: Icons.arrow_forward_ios,
                      onPressed: () {
                        // My Sketchs 버튼이 눌렸을 때 처리할 내용
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MySketch(),),
                        );
                      },
                    ),
                    ButtonWidget(
                      text: 'My Posts',
                      color: '8584DF',
                      bg: 'D4D6F5',
                      icon1: Icons.signpost,
                      icon2: Icons.arrow_forward_ios,
                      onPressed: () {
                        // My Sketchs 버튼이 눌렸을 때 처리할 내용
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyPost(),),
                        );
                      },
                    ),
                    ButtonWidget(
                      text: 'Language',
                      color: '000000',
                      bg: 'C4C4C4',
                      icon1: Icons.language_outlined,
                      icon2: Icons.arrow_forward_ios,
                      onPressed: () {
                        // My Sketchs 버튼이 눌렸을 때 처리할 내용
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SelectLanguage(),),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
