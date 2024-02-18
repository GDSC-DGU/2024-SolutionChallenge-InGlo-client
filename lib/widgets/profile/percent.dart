import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/models/profile/user.dart';

class PercentWidget extends StatelessWidget {
  final User user;

  PercentWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      percentButton(context, '${user.percent}',),
    ],
  );
  Widget buildDivider() => Container(
    width: 70,
    child: Divider(),
  );

  Widget percentButton(BuildContext context, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(height: 70,),
                Text(
                  text,
                  style: GoogleFonts.notoSans(fontWeight: FontWeight.w400, fontSize: 12),
                ),
                buildDivider(),
              ],
            ),
            SizedBox(width: 10,),
          ],
        ),
      );
}