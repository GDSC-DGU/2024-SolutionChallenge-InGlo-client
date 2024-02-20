import 'package:flutter/material.dart';
import 'package:inglo/screens/issue_detail/issue_detail.dart';
import 'package:inglo/service/issuelist/issuelist.dart';

// 더미데이터
final List<Map<String, String>> itemData = [
  {
    "title": "제목1",
    "image":
        "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"
  },
  {
    "title": "제목2",
    "image":
        "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"
  },
  {
    "title": "제목3",
    "image":
        "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"
  },
  {
    "title": "제목4",
    "image":
        "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"
  },
];

class IssueItem extends StatelessWidget {
  final int sdgs;
  const IssueItem({required this.sdgs, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: IssueListData(sdgs: sdgs),
    );
  }
}

class IssueListData extends StatelessWidget {
  final int sdgs;
  const IssueListData({required this.sdgs, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: IssueSdgsService().getIssueSdgs(sdgs),
      builder: (context, snapshot) {
        var data = snapshot.data!;
        return Column(
          children: data
              .map((item) => InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => IssueDetailPage(itemId: item.id),
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
                                  Text(
                                    item.title,
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(item.description.length >= 20 ? '${item.description.substring(0, 20)}...' : item.description),
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
