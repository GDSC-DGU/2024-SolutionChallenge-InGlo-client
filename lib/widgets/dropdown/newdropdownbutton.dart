import 'package:flutter/material.dart';

// 드롭다운 데이터
const List<String> list = <String>['No Poverty', 'Zero Hunger', 'Good Health And Well-Being', 'Quality Education'];

class SDGSMenu extends StatefulWidget {
  const SDGSMenu({super.key});

  @override
  State<SDGSMenu> createState() => _SDGSMenuState();
}

class _SDGSMenuState extends State<SDGSMenu> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //const Text("Recommand"),
          DropdownMenu<String>(
            initialSelection: list.first,
            onSelected: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            textStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            // label: const Text("SDGs"),
            inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
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

            dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),

        ],
      ),
    );
  }
}
