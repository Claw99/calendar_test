// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:calendar/theme/theme.dart';

class YearsPicker extends StatefulWidget {
  final void Function(int?)? onChanged;
  const YearsPicker({
    Key? key,
    this.onChanged,
  }) : super(key: key);

  @override
  State<YearsPicker> createState() => _YearsPickerState();
}

class _YearsPickerState extends State<YearsPicker> {
  String? selectedValue;

  int year = DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<int>(
        onChanged: widget.onChanged,
        value: year,
        isExpanded: true,
        hint: Row(
          children: [
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                '$year',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: [
          for (int year = DateTime.now().year;
              year <= DateTime.now().year + 4;
              year++)
            DropdownMenuItem<int>(
              value: year,
              child: Text(
                year.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                overflow: TextOverflow.visible,
              ),
            )
        ],
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
          icon: const Icon(
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
