import 'package:flutter/material.dart';
import 'package:my_app/model/entry.dart';
import 'package:my_app/page/single-entry/single_entry.dart';
import 'date_time_container.dart';

class AllEntriesView extends StatelessWidget {
  final _listTileTitleFont = const TextStyle(fontSize: 10);
  final _listTileSubtitleFont = const TextStyle(fontSize: 10);

  final List<Entry>? entries;

  const AllEntriesView({Key? key, required this.entries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.only(top: 10.0),
        itemCount: entries!.length,
        separatorBuilder: (context, i) {
          return const Divider();
        },
        itemBuilder: (BuildContext context, i) {
          final Entry entry = entries![i];
          return ListTile(
            visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
            title: Text(entry.title, style: _listTileTitleFont),
            subtitle:
                Text(entry.content, maxLines: 2, style: _listTileSubtitleFont),
            trailing: DateTimeDisplay(creationTime: entry.creationTime),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(todo: entries![i]),
                ),
              );
            },
          );
        });
  }
}
