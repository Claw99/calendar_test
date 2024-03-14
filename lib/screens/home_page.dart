import 'package:calendar/screens/custom_calendar_screen.dart';
import 'package:calendar/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import 'cases_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _curentPageIndex = 0;
  int bottomIndex = 0;
  final List<Widget> pages = [CaseScreen(), CalendarView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_curentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: bottomIndex,
          onTap: (value) {
            setState(() {
              _curentPageIndex = value;
              bottomIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.check_box),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined),
              label: 'Calendar',
            ),
          ]),
    );
  }
}
