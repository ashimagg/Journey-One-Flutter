import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeDisplay extends StatelessWidget {
  final _timeFont = const TextStyle(fontSize: 8);
  final _dateFont = const TextStyle(fontSize: 12);

  final DateTime creationTime;

  const DateTimeDisplay({Key? key, required this.creationTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String weekDayText =
        DateFormat('EEEE').format(creationTime).substring(0, 3);
    int creationDay = creationTime.day;
    String dateText = creationDay < 10
        ? "0" + creationDay.toString()
        : creationDay.toString();
    String creationTimeText = DateFormat("h:mm a").format(creationTime);
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          margin: const EdgeInsets.only(bottom: 4.0),
          padding: const EdgeInsets.all(4.0),
          decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Column(children: [
            Text(weekDayText, style: _timeFont),
            Text(dateText, style: _dateFont)
          ])),
      Text(creationTimeText, style: _timeFont)
    ]);
  }
}
