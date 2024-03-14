// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:calendar/data/SQLite_helper.dart';
import 'package:calendar/widgets/alert_widgets.dart';
import 'package:flutter/material.dart';

import 'package:calendar/theme/theme.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import 'customButton.dart';
import 'custom_textfield.dart';

class AddingCaseDialog extends StatefulWidget {
  final String day;

  const AddingCaseDialog({
    Key? key,
    required this.day,
  }) : super(key: key);

  @override
  State<AddingCaseDialog> createState() => _AddingCaseDialogState();
}

class _AddingCaseDialogState extends State<AddingCaseDialog>
    with SingleTickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TimeOfDay _selectedTime = TimeOfDay.now();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late String caseName = '';
  late String imagePath = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void save(String? name) {
    if (_formKey.currentState!.validate()) _formKey.currentState!.save();
    caseName = name ?? '';
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String date = widget.day;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ThemeClass().cream),
                  width: size.width / 1.3,
                  height: size.height / 3.5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'A new event on ',
                          style: TextStyle(
                              fontSize: 17, color: ThemeClass().white),
                        ),
                        Text(
                          date,
                          style: TextStyle(fontSize: 19),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Form(
                              key: _formKey,
                              child: CustomTextField(
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Enter your event name';
                                  }
                                  return null;
                                },
                                controller: nameController,
                                onSaved: save,
                                content: 'Event\'s name ',
                                onSubmited: (val) {
                                  caseName = val;
                                },
                              ),
                            )),
                        CustomButton(
                            text: 'Select time',
                            onPressed: () {
                              _selectTime(context);
                            }),
                        CustomButton(
                          onPressed: () async {
                            final String name = nameController.text.trim();
                            final String image = '';
                            final String day = widget.day;
                            final String time = _selectedTime.format(context);
                            if (name.isEmpty) {
                              return;
                            }
                            try {
                              SQLiteHelper()
                                  .insertData(day, name, imagePath, time);
                              List<Map<String, dynamic>> allData =
                                  await SQLiteHelper().getAllData();

                              // ignore: use_build_context_synchronously
                              Utils().customSnackBar(
                                  context, 'Event added  to  calendar');
                              print('All data in the database: $allData');
                              Navigator.pop(context);
                            } on DatabaseException catch (e) {
                              print(e);
                            } catch (e) {}
                          },
                          text: 'Add to calendar',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
