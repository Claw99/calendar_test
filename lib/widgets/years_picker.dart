import 'package:calendar/theme/theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class YearsPicker extends StatefulWidget {
  final Function onYearChanged;
  const YearsPicker({super.key, required this.onYearChanged});

  @override
  State<YearsPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<YearsPicker> {
  String? selectedValue;

  int year = DateTime.now().year;

  final List<int> years1 = [
    2023,
    2024,
    2025,
    2026,
  ];
  final List<String> yearsAsString = [];

  @override
  Widget build(BuildContext context) {
    final List<String> yearsAsString =
        years1.map((int year) => year.toString()).toList();
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                '$year',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: yearsAsString
            .map((String year) => DropdownMenuItem<String>(
                  value: year,
                  child: Text(
                    year,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ))
            .toList(),
        value: year.toString(),
        onChanged: (value) {
          setState(() {
            year = int.parse(value!);
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: MediaQuery.of(context).size.width / 4,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white,
            ),
            color: ThemeClass().blue,
          ),
          elevation: 2,
        ),
        iconStyleData: IconStyleData(
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: ThemeClass().grey,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ThemeClass().cream,
          ),
          offset: const Offset(4, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: MediaQuery.of(context).size.width / 10,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
