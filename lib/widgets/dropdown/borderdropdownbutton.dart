import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class BorderCustomDropdown extends StatefulWidget {
  final List<String> options; // 이 위젯으로 전달될 데이터
  const BorderCustomDropdown({Key? key, required this.options}) : super(key: key);

  @override
  State<BorderCustomDropdown> createState() => _BorderCustomDropdownState();
}

class _BorderCustomDropdownState extends State<BorderCustomDropdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {

    Color borderColor = selectedValue != null ? Color(0xFFFFD691) : Color(0xFFC4C4C4);
    return Scaffold(
      body: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: const Row(
            children: [
              Expanded(
                child: Text(
                  'select SDGS',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF696969),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: widget.options
              .map((String item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
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
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color(0xFFC4C4C4), // 테두리 색상
                width: 1.0, // 테두리 두께
              ),
              color: Colors.transparent, // 배경색 설정
            ),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
              size: 25,
            ),
            iconSize: 14,
            iconEnabledColor: Color(0xFFC4C4C4),
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 300,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color(0xFFC4C4C4), // 테두리 색상
                width: 1.0, //// 테두리 두께 설정
              ),
              color: Color(0xFFFFD691),
            ),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all<double>(6),
              thumbVisibility: MaterialStateProperty.all<bool>(false),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 50,
            padding: EdgeInsets.all(8.0),
          ),
        ),
      ),
    );
  }
}