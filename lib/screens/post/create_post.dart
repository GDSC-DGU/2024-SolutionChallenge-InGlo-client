import 'package:flutter/material.dart';

class  CreatePost extends StatelessWidget {
  const CreatePost ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.arrow_back),
            const SizedBox(
              width: 20,
            ),
            Text('Create Post'),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              onPressed: () {},
              child: Text('Post'),
            )
          ],
        ),
        Divider(
          thickness: 1,
        ),
        const SizedBox(
          height: 20,
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/4/44/Facebook_Logo.png'),
          title: Text("Username Here"),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey),
                    onPressed: () {},
                    icon: Icon(Icons.group),
                    label: Row(
                      children: [
                        Text('Friends'),
                        Expanded(
                          child: Icon(
                            Icons.arrow_drop_down,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey),
                    onPressed: () {},
                    icon: Icon(Icons.add),
                    label: Row(
                      children: [
                        Text('Album'),
                        Expanded(
                          child: Icon(
                            Icons.arrow_drop_down,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          maxLines: 5,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'What\'s on your Mind?',
            hintStyle: TextStyle(fontSize: 20),
          ),
        ),
      ],
    ),
    );
  }
}
