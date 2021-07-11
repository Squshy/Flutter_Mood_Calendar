import 'package:intl/intl.dart';

class Mood {
  Mood({this.mood, this.mdate, this.feelingDescription, this.userId});

  int id;
  int mood;
  String feelingDescription;
  DateTime mdate;
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  int userId;

  Mood.fromMap(Map<String, dynamic> map) {
    print("FROM MAP: ${map["mdate"]}");
    this.id = map['id'];
    this.mood = map['mood'];
    this.mdate = DateTime.parse(map['mdate']);
    this.feelingDescription = map['feelingDescription'];
    this.userId = map['user_id'];
  }

  Map<String, dynamic> toMap() {
    print("TOMAP: ${this.formatter.format(mdate)}");
    return {
      'id': this.id,
      'mood': this.mood,
      'mdate': this.formatter.format(mdate),
      'feelingDescription': this.feelingDescription,
      'user_id': this.userId,
    };
  }

  String toString() {
    return 'Mood{id: $id, mood: $mood, mdate: $mdate, feelingDescription: $feelingDescription, user: $userId}';
  }
}
