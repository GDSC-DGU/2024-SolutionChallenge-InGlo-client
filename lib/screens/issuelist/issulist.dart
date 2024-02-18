import 'package:flutter/material.dart';
import 'package:inglo/screens/issuelist/sdgs_select.dart';
import 'package:inglo/screens/issuelist/widgets/issue_item.dart';
import 'package:inglo/screens/issuelist/widgets/issue_choose.dart';
import 'package:inglo/screens/issuelist/widgets/issue_slider.dart';
import 'package:inglo/widgets/appbar/appbar.dart';

class IssueListPage extends StatefulWidget {
  // 나중에 폰트 스타일 다시 재정의!
  static const titleStyle =
      TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.w700);

  @override
  State<IssueListPage> createState() => _IssueListPageState();
}

class _IssueListPageState extends State<IssueListPage> {
  int sdgs = 1; // 1~17?


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IssueMenu(
                  selectedSdgs: sdgs,
                  onSdgsTap: (int sdgs) {
                    setState(() {
                      this.sdgs = sdgs;
                    });
                  }
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child:
                      const Text("Recommand", style: IssueListPage.titleStyle),
                ),
                IssueSlider(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: const Text("Today's Issue",
                      style: IssueListPage.titleStyle),
                ),
                IssueItem(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SDGSSelectPage(),
            ),
          );
        },
        backgroundColor: const Color(0xFF233A66),
        label: const Text(
          'Design',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        icon: const Icon(
          Icons.palette,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: NavigationAppBar(
        currentIndex: 0, // index 전송
      ),
    );
  }
}
