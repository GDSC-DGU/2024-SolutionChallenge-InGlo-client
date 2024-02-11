import 'package:flutter/material.dart';

class IssueInput extends StatelessWidget {
  const IssueInput({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 90,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Color(0xFFF7EEDE),
          border: Border(
            top: BorderSide(
              color: Color(0xFFD7A859),
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter your comment",
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.send,
                size: 25,
                color: Color(0xFFD7A859),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
