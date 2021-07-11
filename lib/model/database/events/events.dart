import 'package:intl/intl.dart';

class Events {
  Events({this.title, this.description, this.date});

  int id;
  String title;
  String description;
  DateTime date = new DateTime.now();
  DateFormat formatter = DateFormat('yyyy-mm-dd');

  Events.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.description = map['description'];
    this.date = map['date'];
  }

  Map<String, dynamic> toMap(){
    return{
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'date': this.formatter.format(date),
    };
  }

  String tostring() {
    return 'Mood{id: $id, title: $title, description: $description, when: $date}';
  }


}