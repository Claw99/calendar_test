import 'dart:developer';

import 'package:calendar/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  static const _scopes = const [CalendarApi.calendarScope];
  void prompt(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  insertEvent(event) {
    try {
      ClientId _clientId = ClientId(
          '688541885728-gtsc92c7tg9s9i8iqseukgp0usrka4on.apps.googleusercontent.com');
      clientViaUserConsent(_clientId, _scopes, prompt)
          .then((AuthClient client) {
        var calendar = CalendarApi(client);
        String calendarId = "primary";
        calendar.events.insert(event, calendarId).then((value) {
          print("ADDEDDD_________________${value.status}");
          if (value.status == "confirmed") {
            log('Event added in google calendar');
          } else {
            log("Unable to add event in google calendar");
          }
        });
      });
    } catch (e) {
      log('Error creating event $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Calendar'),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(2024, 5, 5, 20, 50),
              firstDate: DateTime(2020, 5, 5, 20, 50),
              lastDate: DateTime(2025, 5, 5, 20, 50),
            );

            if (selectedDate != null) {
              insertEvent(selectedDate);
            }
          },
          child: Text('Pick date'),
        ),
      ),
    );
  }
}
