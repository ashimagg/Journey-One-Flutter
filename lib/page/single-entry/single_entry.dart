import 'package:flutter/material.dart';
import 'package:my_app/model/entry.dart';

class DetailScreen extends StatelessWidget {
  // In the constructor, require a Todo.
  const DetailScreen({Key? key, required this.todo}) : super(key: key);

  // Declare a field that holds the Todo.
  final Entry todo;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(todo.content),
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _bottomBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.mode_edit),
          onPressed: _pushSaved,
          tooltip: 'Saved Suggestions',
        ),
        const Text("Edit Info")
      ],
    );
  }

  void _pushSaved() {}
}
