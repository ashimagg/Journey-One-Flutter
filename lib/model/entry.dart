class Entry {
  String entryId;
  String userId;
  String title;
  String content;
  String journalId;
  DateTime creationTime;
  List<String> labels = [];

  Entry(this.entryId, this.userId, this.title, this.content, this.journalId,
      this.creationTime, this.labels);

  factory Entry.fromJson(dynamic json) {
    return Entry(
        json['entryId'],
        json['userId'],
        json['title'],
        json['content'],
        json['journalId'],
        DateTime.parse(json['creationTime']),
        List<String>.from(json['labels']));
  }
}
