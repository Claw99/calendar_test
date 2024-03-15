// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:calendar/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'years_picker.dart';

enum Months {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december,
}

class MonthBuilder extends StatefulWidget {
  final PageController controller;

  const MonthBuilder({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<MonthBuilder> createState() => _MonthBuilderState();
}

class _MonthBuilderState extends State<MonthBuilder> {
  DateTime _currentMonth = DateTime.now();
  @override
  Widget build(BuildContext context) {
    PageController controller = widget.controller;

    bool isLastMonthOfYear = _currentMonth.month == 12;

    return Container(
      height: 30,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _currentMonth = _currentMonth.subtract(Duration(days: 30));
                });
                if (controller.page! > 0) {
                  controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                }
              },
              child: const Icon(
                Icons.arrow_back,
                size: 25,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              '${DateFormat('MMMM').format(_currentMonth)}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          YearsPicker(
            onChanged: (int? year) {
              if (year != null) {
                setState(() {
                  _currentMonth = DateTime(year, 1, 1);

                  int yearDiff = DateTime.now().year - year;
                  int monthIndex = 12 * yearDiff + _currentMonth.month - 1;
                  controller.jumpToPage(monthIndex);
                });
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _currentMonth = _currentMonth.add(Duration(days: 30));
                });
                if (!isLastMonthOfYear) {
                  controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                }
              },
              child: const Icon(
                Icons.arrow_forward,
                size: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget decorativeContainer(
  Widget child,
) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 1),
    child: Container(
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    ),
  );
}
