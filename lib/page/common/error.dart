import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
              icon: const Icon(Icons.heart_broken_outlined),
              onPressed: _pushSaved),
          const Text("Oops! Something Went Wrong.")
        ]));
  }

  void _pushSaved() {}
}
