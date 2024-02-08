import 'package:flutter/material.dart';

class IssueContent extends StatelessWidget {
  const IssueContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Text("container"),
          Positioned(
            right: 20,
            top: -40,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color(0xFFD7A859)),
              ),
              onPressed: () {},
              child: Text(
                "Let's Design",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
