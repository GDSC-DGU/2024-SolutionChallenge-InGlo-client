import 'package:flutter/material.dart';
import 'package:inglo/models/issuelist/issue_sdgs.dart';
import 'package:inglo/screens/issue_detail/issue_detail.dart';
import 'package:inglo/service/issue/issuelist.dart';
import 'package:inglo/service/translate/translate_util.dart';

class IssueItem extends StatelessWidget {
  final int sdgs;
  final token;
  const IssueItem({required this.sdgs, required this.token, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: IssueListData(
        sdgs: sdgs,
        token: token,
      ),
    );
  }
}

class IssueListData extends StatelessWidget {
  final int sdgs;
  final token;
  const IssueListData({required this.sdgs, required this.token, super.key});


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: IssueSdgsService().getIssueSdgs(sdgs, token),
      builder: (context, snapshot) {
        var data = snapshot.data!;
        return Column(
          children: data
              .map((item) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              IssueDetailPage(itemId: item.id),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFFFD691),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 5, 10, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (item.title != null)
                                    FutureBuilder(
                                      future: TranslationService()
                                          .getTranslation("ko", item.title),
                                      builder: (context, snapshot) {
                                        var transData = snapshot.data!;
                                        return Text(
                                          transData.length >= 40
                                              ? '${transData.substring(0, 40)}...'
                                              : transData,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      },
                                    ),
                                  if (item.description != null)
                                    FutureBuilder(
                                      future: TranslationService()
                                          .getTranslation(
                                              "ko", item.description),
                                      builder: (context, snapshot) {
                                        var transData = snapshot.data!;
                                        return Text(
                                          transData.length >= 20
                                              ? '${transData.substring(0, 20)}...'
                                              : transData,
                                        );
                                      },
                                    ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: Color(0xFFD7A859),
                                        size: 20.0,
                                      ),
                                      Text(item.likes.toString()),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.visibility,
                                        color: Color(0xFFD7A859),
                                        size: 20.0,
                                      ),
                                      SizedBox(width: 2),
                                      Text(item.views.toString()),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (item.imageUrl != "")
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              child: Image.network(
                                item.imageUrl,
                                fit: BoxFit.cover,
                                width: 100.0,
                                height: 80.0,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        );
      },
    );
  }
}
