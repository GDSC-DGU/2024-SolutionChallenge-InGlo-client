import 'package:flutter/material.dart';

class PercentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      percentButton(context, '50%',),
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
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                ),
                buildDivider(),
              ],
            ),
            SizedBox(width: 10,),
          ],
        ),
      );
}