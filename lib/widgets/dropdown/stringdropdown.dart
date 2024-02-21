import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BorderCustomDropdown extends StatefulWidget {
  final List<Map<String, dynamic>> options; // 데이터 옵션
  final void Function(String?) onChanged;


  // 매개변수로 받은 값으로 생성자 생섵
  const BorderCustomDropdown({
    Key? key,
    required this.options,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<BorderCustomDropdown> createState() => _BorderCustomDropdownState();
}

class _BorderCustomDropdownState extends State<BorderCustomDropdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    Color borderColor =
        selectedValue != null ? Color(0xFFFFD691) : Color(0xFFC4C4C4);
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
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF696969),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: widget.options
              .map((Map<String, dynamic> item) => DropdownMenuItem<String>(
                    value: item['value'],
                    child: Text(
                      item['value'],
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue; // 내부 상태 업데이트
            });
            widget.onChanged(newValue); // 선택된 value를 부모 위젯에 전달
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
              color: Colors.white, // 배경색 설정
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
