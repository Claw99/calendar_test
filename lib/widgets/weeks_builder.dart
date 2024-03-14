import 'package:calendar/models/day_cell_model.dart';
import 'package:calendar/widgets/month_builder.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'adding_case_dialog.dart';
import 'years_picker.dart';

class CalendarBuilder extends StatelessWidget {
  const CalendarBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> days = [
      'Mon',
      'Tue',
      'Wed',
      'Thi',
      'Fri',
      'Sat',
      'Sun',
    ];
    PageController _pageController =
        PageController(initialPage: DateTime.now().month - 1);

    DateTime _currentMonth = DateTime.now();

    final Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height / 1.8,
      child: Column(
        children: [
          MonthBuilder(
            controller: _pageController,
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: size.height / 33,
            child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                      width: size.width / 13,
                    ),
                itemCount: days.length,
                padding: EdgeInsets.only(left: size.width / 22),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Text(days[index]);
                }),
          ),
          Expanded(
            child: PageView.builder(
                controller: _pageController,
                itemCount: 12 * 5,
                itemBuilder: (context, index) {
                  DateTime month =
                      DateTime(_currentMonth.year, (index % 12) + 1, 1);
                  return dayCellsBuilder(month);
                }),
          ),
        ],
      ),
    );
  }
}

Widget dayCellsBuilder(DateTime month) {
  int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
  DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);
  int weekdayOfFirstDay = firstDayOfMonth.weekday;
  DateTime lastDayOfPreviousMonth =
      firstDayOfMonth.subtract(const Duration(days: 1));
  int daysInPreviousMonth = lastDayOfPreviousMonth.day;
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
    ),
    child: GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      itemCount: daysInMonth + weekdayOfFirstDay - 1,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 7,
          childAspectRatio: 9 / 10),
      itemBuilder: (context, index) {
        if (index < weekdayOfFirstDay - 1) {
          int previousMonthDay =
              daysInPreviousMonth - (weekdayOfFirstDay - index) + 2;
          return Container(
            height: 60,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                previousMonthDay.toString(),
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        } else {
          DateTime date =
              DateTime(month.year, month.month, index - weekdayOfFirstDay + 2);
          String text = date.day.toString();
          String day = DateFormat('dd.MM').format(date);
          return GestureDetector(
              onTap: () {
                showCustomDialog(context, day);
              },
              child: singleDay(text));
        }
      },
    ),
  );
}

Widget singleDay(String text) {
  return Container(
    height: 60,
    width: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        width: 1,
      ),
    ),
    child: Center(
      child: Text(text),
    ),
  );
}

void showCustomDialog(BuildContext context, String day) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddingCaseDialog(
          day: day,
        );
      });
}
