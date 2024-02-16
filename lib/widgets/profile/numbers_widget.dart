import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      buildButton(context, '30', 'Liked'),
      buildButton(context, '35', 'Posting'),
      buildButton(context, '50', 'Feedbacks'),
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
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
            ),
            buildDivider(),
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12),
            ),
          ],
        ),
      );
}