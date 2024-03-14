import 'package:calendar/models/day_cell_model.dart';
import 'package:calendar/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import '../widgets/weeks_builder.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: 'Calendar'),
      body: Column(
        children: [
          CalendarBuilder(),
        ],
      ),
    );
  }
}
