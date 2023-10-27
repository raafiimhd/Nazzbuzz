import 'package:hive_flutter/hive_flutter.dart';
import 'package:nazzbuzz/model/recently_played_model/recent_model.dart';

late Box<RecentlyPlayed> recentlyPlayedDb;
openRecentlyPlayedDB() async {
  recentlyPlayedDb = await Hive.openBox<RecentlyPlayed>('recently_played');
}

updateRecentlyPlayed(RecentlyPlayed value) {
  List<RecentlyPlayed> list = recentlyPlayedDb.values.toList();
  bool isAlready =
      list.where((element) => element.title == value.title).isEmpty;

  if (isAlready) {
    recentlyPlayedDb.add(value);
  } else {
    int index = list.indexWhere((element) => element.title == value.title);
    recentlyPlayedDb.deleteAt(index);
    recentlyPlayedDb.add(value);
  }
}

clearRecently() async {
   recentlyPlayedDb = await Hive.openBox<RecentlyPlayed>('recently_played');
  recentlyPlayedDb.clear();
}
