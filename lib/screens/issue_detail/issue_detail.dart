import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/screens/issue_detail/widgets/issue_content.dart';
import 'package:inglo/screens/issue_detail/widgets/issue_input.dart';
import 'package:inglo/widgets/comment/issue_comment.dart';
import 'package:inglo/service/issue/issue_detail.dart';
import 'package:inglo/widgets/comment/comment_box.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class IssueDetailPage extends StatefulWidget {
  final int itemId;
  const IssueDetailPage({required this.itemId, super.key});

  @override
  State<IssueDetailPage> createState() => _IssueDetailPageState();
}

class _IssueDetailPageState extends State<IssueDetailPage> {
  bool isBookMarked = false;
  final issue_id = 0; // issue id(임시값)
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {

    onClickLike() {
      setState(() {
        isLiked = !isLiked;
      });
    }

    final int itemId = widget.itemId;

    return Scaffold(
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: FutureBuilder(
                  future: IssueDetailService().getIssueDetail(itemId),
                  builder: (context, snapshot) {
                    var data = snapshot.data!;
                    isLiked = data.userHasLiked;
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: data.imageUrl != ""
                          ? BoxDecoration(
                              color: Colors.black45,
                              image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                    Colors.black54, BlendMode.darken),
                                alignment: Alignment.topCenter,
                                fit: BoxFit.fitHeight,
                                image: NetworkImage(data.imageUrl),
                              ),
                            )
                          : BoxDecoration(
                              color: Color(0xFFFFD691),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black54,
                                  Colors.grey,
                                ],
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
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          IssueDetailService().postIssueLike(data.id, onClickLike);
                                        },
                                        icon: Icon(
                                          isLiked
                                              ? Icons.favorite
                                              : Icons.favorite_border_outlined,
                                          size: 30,
                                          color: Color(0xFFFF6280),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.createdAt.substring(0, 10),
                                        style: GoogleFonts.notoSans(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        data.title,
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
                                        data.writer,
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
                                  child: IssueContent(data: data),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          //IssueComment(),
        ],
      ),
      //bottomSheet: IssueInput(),
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ElevatedButton(
          onPressed: () {
            showBarModalBottomSheet(
              expand: false,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) => IssueComments(id: issue_id),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFF7EEDE),
            elevation: 0,
            side: BorderSide(
              color: Color(0xFFD7A859),
              width: 1,
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
          child: Icon(
            Icons.comment_outlined,
            size: 35,
            color: Color(0xFFD7A859),
          )
        ),
      ),
    );
  }
}
