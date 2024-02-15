import 'package:flutter/material.dart';

class PostUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    child: Icon(
                      Icons.person_2_outlined,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    "name",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Color(0xFFFF6E80),
                    size: 10.0,
                  ),
                  Text(
                    "12",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  Icon(
                    Icons.visibility,
                    color: Color(0xFFD7A859),
                    size: 10.0,
                  ),
                  Text(
                    "12",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
