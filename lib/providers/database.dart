import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/model/entry.dart';
import 'package:my_app/utils/http_loader.dart';

final dataBaseProvider = Provider<DataBase>((ref) => DataBase());

class DataBase {
  Future<List<Entry>> getEntries(String userId, String token) async {
    final httpLoader = HttpLoader();
    String jsonString = await httpLoader.getPositions(userId, token);

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
