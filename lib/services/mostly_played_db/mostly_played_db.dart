import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nazzbuzz/model/mostly_played_model/mostly_played.dart';

late Box<MostlyPlayed> mostlyPlayedDb;
ValueNotifier<List<MostlyPlayed>> MostlyPlayedNotifier = ValueNotifier([]);

openMostly() async {
  mostlyPlayedDb = await Hive.openBox<MostlyPlayed>('mostly_played');
}

addMostlyPlayedSong(MostlyPlayed song) async {
  List<MostlyPlayed> mostlyPlayedList = mostlyPlayedDb.values.toList();
  if (mostlyPlayedList
      .where((element) => element.title == song.title)
      .isEmpty) {
    mostlyPlayedDb.put(song.id, song);
  } else {
    MostlyPlayed? sog = mostlyPlayedDb.get(song.id);
    int count = sog?.count ?? 0;
    song.count = count + 1;
    await mostlyPlayedDb.put(song.id, song);
  }
  MostlyPlayedNotifier.notifyListeners();
}

List<MostlyPlayed> sortMostlyPlayed() {
  List<MostlyPlayed> sortList = [];

  sortList = mostlyPlayedDb.values.toList();
  sortList.sort(
    (a, b) => (b.count ?? 0).compareTo(a.count ?? 0),
  );
  List<MostlyPlayed> mostlyPlayedSortList = [];

  for (final element in sortList) {
    if (element.count != null) {
      if (element.count != 3) {
        mostlyPlayedSortList.add(element);
      } else {
        return mostlyPlayedSortList;
      }
    }
  }
   MostlyPlayedNotifier.notifyListeners();
  return mostlyPlayedSortList;
}

clearMostly() async {
  mostlyPlayedDb = await Hive.openBox<MostlyPlayed>('mostly_played');
  mostlyPlayedDb.clear();
}
