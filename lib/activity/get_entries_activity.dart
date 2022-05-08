import 'dart:convert';

import 'package:my_app/model/entry.dart';
import 'package:my_app/utils/http_loader.dart';

class GetEntriesActivity {
  static Future<List<Entry>> enact(String userId, int n) async {
    final httpLoader = HttpLoader();
    String jsonString = await httpLoader.getPositions(userId);

    try {
      List<Entry> entries = [];
      List<dynamic> dynamoEntries = jsonDecode(jsonString);
      for (dynamic dynamoEntry in dynamoEntries) {
        entries.add(Entry.fromJson(dynamoEntry));
      }
      return entries;
    } on FormatException {
      throw Exception("Could not format API Response JSON");
    }
  }
}
