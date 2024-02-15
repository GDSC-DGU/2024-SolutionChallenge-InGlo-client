import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({super.key});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final List<String> items = [
    'No Poverty', 'Zero Hunger', 'Good Health And Well-Being', 'Quality Education'
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Row(
              children: [
                Expanded(
                  child: Text(
                    'select SDGS',
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: items
                .map((String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.notoSans(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ))
                .toList(),
            value: selectedValue,
            onChanged: (String? value) {
              setState(() {
                selectedValue = value;
              });
            },
            buttonStyleData: ButtonStyleData(
              width: MediaQuery.of(context).size.width * 1,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFD7A859), // 밑면 테두리 색상
                    width: 2.0, // 밑면 테두리 두께
                  ),
                ),
                color: Colors.white,
              ),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                size: 25,
              ),
              iconSize: 14,
              iconEnabledColor: Color(0xFFD7A859),
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 300,
              width: MediaQuery.of(context).size.width * 0.94,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all<double>(6),
                thumbVisibility: MaterialStateProperty.all<bool>(false),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 50,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        ),
    );
  }
}