import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nazzbuzz/core/global.dart';
import 'package:nazzbuzz/database/model/db_model.dart';
import 'package:nazzbuzz/database/model/fav_model.dart';

ValueNotifier<List<SongInfo>> favaroList = ValueNotifier([]);

Future<void> addFavourite(SongInfo songs) async {
  favaroList.value.insert(0, songs);
  Box<Favmodel> favDb = await Hive.openBox<Favmodel>('Favaourites');
  Favmodel temp = Favmodel(id: songs.id);
  await favDb.add(temp);
  favaroList.notifyListeners();
}

getFAvourite() async {
  favaroList.value.clear();
  List<Favmodel> favSongCheck = [];
  final favDb = await Hive.openBox<Favmodel>('Favaourites');
  favSongCheck.addAll(favDb.values);
  for (var favs in favSongCheck) {
    int count = 0;
    for (var songs in allsongs) {
      if (favs.id == songs.id) {
        favaroList.value.add(songs);
        break;
      } else {
        count++;
      }
    }
    if (count == allsongs.length) {
      var key = favs.key;
      favDb.delete(key);
    }
  }
  favaroList.notifyListeners();
}

removeFavourite(SongInfo song) async {
  favaroList.value.remove(song);
  List<Favmodel> templist = [];
  Box<Favmodel> favdb = await Hive.openBox('Favaourites');
  templist.addAll(favdb.values);
  for (var element in templist) {
    if (element.id == song.id) {
      var key = element.key;
      favdb.delete(key);
      break;
    }
  }
  favaroList.notifyListeners();
  getFAvourite();
}

clearFav() async {
 Box<Favmodel> favDb = await Hive.openBox<Favmodel>('Favaourites');
  await favDb.clear();
}
