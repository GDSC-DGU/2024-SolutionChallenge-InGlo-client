import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:inglo/screens/issue_detail/issue_detail.dart';
import 'package:inglo/service/issue/issuelist.dart';
import 'package:inglo/service/translate/translate_util.dart';

// 더미데이터
final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class IssueSlider extends StatelessWidget {
  final String? token;
  const IssueSlider({required this.token, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: IssueTop3Service().getIssueTop3(token),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            return const Center(child: Text('error')); // 에러 발생 시
          } else {
            var data = snapshot.data!;
            return CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items: data
                  .map((item) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => IssueDetailPage(
                                itemId: item.id,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5.0),
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              child: Stack(
                                children: <Widget>[
                                  item.imageUrl != ""
                                      ? Image.network(item.imageUrl,
                                          fit: BoxFit.cover, width: 1000.0)
                                      : Container(
                                          width: 1000,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFFFD691),
                                          ),
                                        ),
                                  Positioned(
                                    bottom: 0.0,
                                    left: 0.0,
                                    right: 0.0,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromARGB(200, 0, 0, 0),
                                            Color.fromARGB(0, 0, 0, 0)
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (item.title != null)
                                            FutureBuilder(
                                              future: TranslationService()
                                                  .getTranslation(
                                                      item.title, context),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Center(
                                                      child:
                                                          Text("loading..."));
                                                } else {
                                                  if (snapshot.hasError) {
                                                    return const Center(
                                                        child: Text(
                                                            'error')); // 에러 발생 시
                                                  } else {
                                                    var transData =
                                                        snapshot.data!;
                                                    return Text(
                                                      transData.length >= 40
                                                          ? '${transData.substring(0, 40)}...'
                                                          : transData,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    );
                                                  }
                                                }
                                              },
                                            ),
                                          if (item.description != null)
                                            FutureBuilder(
                                              future: TranslationService()
                                                  .getTranslation(
                                                      item.description,
                                                      context),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Center(
                                                      child:
                                                          Text("loading..."));
                                                } else {
                                                  if (snapshot.hasError) {
                                                    return const Center(
                                                        child: Text(
                                                            'error')); // 에러 발생 시
                                                  } else {
                                                    var transData =
                                                        snapshot.data!;
                                                    return Text(
                                                      transData.length >= 30
                                                          ? '${transData.substring(0, 30)}...'
                                                          : transData,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    );
                                                  }
                                                }
                                              },
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ))
                  .toList(),
            );
          }
        }
      },
    );
  }
}
