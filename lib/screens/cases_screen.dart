import 'package:calendar/data/SQLite_helper.dart';
import 'package:calendar/models/case_model.dart';
import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';
import '../widgets/case_item.dart';

class CaseScreen extends StatefulWidget {
  const CaseScreen({super.key});

  @override
  State<CaseScreen> createState() => _CaseScreenState();
}

class _CaseScreenState extends State<CaseScreen> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    SQLiteHelper sqliteHelper = SQLiteHelper();

    List<Map<String, dynamic>> queryResult = await sqliteHelper.getAllData();

    setState(() {
      data = queryResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My Events'),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return data.isNotEmpty
                      ? CaseItem(
                          model: CaseModel(
                            beginingDay: DateTime.now(),
                            beginingTime: '${data[index]['time']}',
                            caseName: '${data[index]['name']}',
                          ),
                        )
                      : const Center(
                          child: Text(
                            'You have no event yet',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        );
                }),
          ),
        ],
      ),
    );
  }
}
