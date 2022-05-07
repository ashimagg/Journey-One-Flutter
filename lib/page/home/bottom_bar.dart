import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.view_agenda),
          onPressed: _pushSaved,
          tooltip: 'Saved Suggestions',
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: _pushSaved,
          tooltip: 'Saved Suggestions',
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _pushSaved,
          tooltip: 'Saved Suggestions',
        ),
        IconButton(
          icon: const Icon(Icons.calendar_month),
          onPressed: _pushSaved,
          tooltip: 'Saved Suggestions',
        )
      ],
    );
  }

  void _pushSaved() {}
}
