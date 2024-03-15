import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/SQLite_helper.dart';
import '../models/case_model.dart';

class CaseItem extends StatefulWidget {
  final CaseModel model;
  const CaseItem({super.key, required this.model});

  @override
  State<CaseItem> createState() => _CaseItemState();
}

class _CaseItemState extends State<CaseItem> {
  @override
  Widget build(BuildContext context) {
    CaseModel model = widget.model;
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: Theme.of(context).splashColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    model.beginingDay,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    model.caseName,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(model.beginingTime!)
                ],
              ),
              IconButton(
                onPressed: () async {
                  await SQLiteHelper().deleteData(model.caseName);
                  setState(() {});
                },
                icon: const Icon(
                  Icons.delete_rounded,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
