// Used to fill database with dummy data on first run
import 'model/database/mood/mood.dart';
import 'model/database/mood/mood_model.dart';

final List<Mood> _moods = [
  new Mood(
    mood: 2,
    mdate: DateTime.parse("2020-10-02"),
    feelingDescription:
        'Go module Mirror and Checksum Database Launched (golang.org)',
    userId: 1,
  ),
  new Mood(
    mood: 5,
    mdate: DateTime.parse("2020-10-05"),
    feelingDescription: 'Dqlite - High-Availablity  SQLite (sqlite.io)',
    userId: 1,
  ),
  new Mood(
    mood: 3,
    mdate: DateTime.parse("2020-10-11"),
    feelingDescription:
        'A deep dive into iOS Exploit found in the wild (googeprojectzero.blogspot.com)',
    userId: 1,
  ),
  new Mood(
    mood: 5,
    mdate: DateTime.parse("2020-10-13"),
    feelingDescription: 'NPM Bans Terminal Ads (zdnet.com)',
    userId: 1,
  ),
  new Mood(
    mood: 5,
    mdate: DateTime.parse("2020-10-14"),
    feelingDescription:
        'The Portuguese Bank Note Crisis of 1925 (wikipedia.org)',
    userId: 1,
  ),
  new Mood(
    mood: 1,
    mdate: DateTime.parse("2020-10-15"),
    feelingDescription: 'What\'s below?',
    userId: 1,
  ),
  new Mood(
    mood: 2,
    mdate: DateTime.parse("2020-11-02"),
    feelingDescription: 'Darn',
    userId: 1,
  ),
  new Mood(
    mood: 3,
    mdate: DateTime.parse("2020-11-01"),
    feelingDescription: 'OSRS releases EOC 2!',
    userId: 1,
  ),
  new Mood(
    mood: 4,
    mdate: DateTime.parse("2020-10-31"),
    feelingDescription: 'Lorem',
    userId: 1,
  ),
  new Mood(
    mood: 5,
    mdate: DateTime.parse("2020-10-30"),
    feelingDescription: 'Ipsum',
    userId: 1,
  ),
  new Mood(
    mood: 1,
    mdate: DateTime.parse("2020-10-29"),
    feelingDescription: 'Butterfly flaps its wings',
    userId: 1,
  ),
  new Mood(
    mood: 1,
    mdate: DateTime.parse("2020-10-28"),
    feelingDescription: 'Please overflow don\'t break',
    userId: 1,
  ),
  new Mood(
    mood: 3,
    mdate: DateTime.parse("2020-10-27"),
    feelingDescription: 'Lorem ipsum dolor sit amet',
    userId: 1,
  ),
  new Mood(
    mood: 1,
    mdate: DateTime.parse("2020-10-26"),
    feelingDescription: '',
    userId: 1,
  ),
  new Mood(
    mood: 2,
    mdate: DateTime.parse("2020-10-25"),
    feelingDescription: '',
    userId: 1,
  ),
  new Mood(
    mood: 1,
    mdate: DateTime.parse("2020-10-24"),
    feelingDescription: '',
    userId: 1,
  ),
  new Mood(
    mood: 5,
    mdate: DateTime.parse("2020-10-23"),
    feelingDescription: '',
    userId: 1,
  ),
  new Mood(
    mood: 1,
    mdate: DateTime.parse("2020-10-22"),
    feelingDescription: '',
    userId: 1,
  ),
  new Mood(
    mood: 6,
    mdate: DateTime.parse("2020-12-01"),
    feelingDescription:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas sit amet lacus interdum, tincidunt sem ac, posuere ex. Pellentesque ullamcorper purus nisl, id venenatis nisi pretium a. In consectetur eros et cursus blandit. Maecenas id tellus vel eros consequat porttitor. Maecenas et arcu sodales, posuere neque nec, volutpat arcu. Nullam eu elit ultrices, condimentum arcu et, rhoncus magna. Vivamus volutpat elit vel quam malesuada, iaculis interdum augue malesuada. Pellentesque eget molestie magna, tempus sodales quam. Ut et sapien orci. Proin lacinia commodo egestas.Vivamus mattis, sapien quis gravida bibendum, ex sapien auctor ipsum, nec vulputate elit nunc vitae turpis. Morbi ipsum felis, suscipit sed dignissim sed, facilisis sit amet metus. Cras porta, neque eu molestie aliquet, nisl elit vulputate tortor, non mattis nulla est vel nibh. Praesent nec tempus augue. Nullam ac consectetur turpis, eget ornare dolor. Donec rhoncus efficitur convallis. Cras vitae fermentum metus. Sed at ultricies nibh. Pellentesque porttitor lacus eu nunc viverra, ut suscipit nibh tempus. In hac habitasse platea dictumst. Quisque eros elit, malesuada dictum molestie vitae, mollis ac nulla. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque dapibus venenatis eros, eget finibus orci cursus vel. Donec vitae magna sit amet tortor condimentum dignissim. Cras et tellus sed magna ornare venenatis. Etiam ultricies, ex at vestibulum aliquet, sem ante faucibus ligula, vitae venenatis massa ex et massa. Nunc fermentum ullamcorper eros, ut interdum libero tincidunt a. Integer laoreet vel nisl at egestas. Aliquam sed lacus vel purus aliquet imperdiet. Nunc malesuada, odio nec volutpat rutrum, massa dolor molestie nisi, a varius lorem est sed enim. Nam ultricies convallis leo et commodo. Sed vel laoreet sapien.',
    userId: 1,
  ),
];

// used for adding dummy data
Future<void> _add(Mood mood) async {
  await MoodModel().insertMood(mood);
}

// used for adding dummy data
void addEmBaby(int userID) {
  for (int i = 0; i < _moods.length; i++) {
    print("MOOD ADDING: ${_moods[i].mdate}");
    _moods[i].userId = userID;
    _add(_moods[i]);
  }
}
