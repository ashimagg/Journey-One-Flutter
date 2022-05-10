import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/model/entry.dart';
import 'package:my_app/utils/http_loader.dart';

final databaseProvider = Provider<DataBase>((ref) => DataBase());

class DataBase {
  DataBase() : super();

  Future<List<Entry>> getEntries(GetEntriesRequest getEntriesRequest) async {
    final httpLoader = HttpLoader();

    String jsonString = await httpLoader.getEntries(
        getEntriesRequest.userId, getEntriesRequest.idToken);

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

class GetEntriesRequest {
  final String userId;
  final String idToken;

  GetEntriesRequest(this.userId, this.idToken);
}
