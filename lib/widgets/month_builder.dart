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
  @override
  Widget build(BuildContext context) {
    int currentMonthIndex = DateTime.now().month - 1;
    int currentMonthNumber = currentMonthIndex;
    PageController controller = widget.controller;
    String monthString = Months.values[currentMonthNumber].name;
    DateTime _currentMonth = DateTime.now();
    bool isLastMonthOfYear = _currentMonth.month == 12;

    return Container(
      height: 30,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: GestureDetector(
              onTap: () {
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
              DateFormat('MMMM').format(_currentMonth),
              style: TextStyle(fontSize: 20),
            ),
          ),
          YearsPicker(
            onYearChanged: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: GestureDetector(
              onTap: () {
                _currentMonth = _currentMonth.subtract(Duration(days: 30));
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
