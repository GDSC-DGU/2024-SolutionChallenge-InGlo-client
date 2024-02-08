import 'package:flutter/material.dart';

class IssueComment extends StatelessWidget {
  const IssueComment({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 0.25,
      initialChildSize: 0.25,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          decoration: const BoxDecoration(
            color: Color(0xFFF7EEDE),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "6 comments",
                style: TextStyle(
                  color: Color(0xFFD7A859),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 원형 이미지
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage("https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80")
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Text("writer's name"),
                          SizedBox(height: 10,),
                          Text(
                              "Clean Energy Technological Innovation Reshapes the Future Energy Market"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
