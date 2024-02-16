import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inglo/models/profile/user.dart';

class NumbersWidget extends StatelessWidget {
  final User user;

  NumbersWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      buildButton(context, '${user.liked_total}', 'Liked'),
      buildButton(context, '${user.sketch_num}', 'Sketchs'),
      buildButton(context, '${user.feedback_total}', 'Feedbacks'),
    ],
  );
  Widget buildDivider() => Container(
    height: 12,
    child: VerticalDivider(),
  );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              text,
              style: GoogleFonts.notoSans(fontWeight: FontWeight.w300, fontSize: 12),
            ),
            buildDivider(),
            Text(
              value,
              style: GoogleFonts.notoSans(fontWeight: FontWeight.w300, fontSize: 12),
            ),
          ],
        ),
      );
}