import 'package:flutter/material.dart';
import 'package:inglo/util/dummy/users_sketch.dart';

class IssueMenu extends StatelessWidget {
  final onSdgsTap;
  final int selectedSdgs;

  const IssueMenu({required this.onSdgsTap, required this.selectedSdgs, super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //const Text("Recommand"),
          DropdownMenu<String>(
            initialSelection: usersSketchData[selectedSdgs - 1],
            onSelected: (String? value) {
              // This is called when the user selects an item.
              onSdgsTap(usersSketchData.indexOf(value!) + 1);
            },
            textStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            // label: const Text("SDGs"),
            inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              border: InputBorder.none,
              // filled: true,
              // fillColor: Colors.orange,
              enabledBorder: UnderlineInputBorder(
                //borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(
                  width: 2.0,
                  color: Color(0xFFD7A859),
                )
              ),
            ),
            menuStyle: const MenuStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFFFFD691)),
            ),

            dropdownMenuEntries: usersSketchData.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),

        ],
      ),
    );
  }
}
