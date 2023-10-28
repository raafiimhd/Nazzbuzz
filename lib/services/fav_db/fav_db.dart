import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nazzbuzz/model/allsongs_model/db_model.dart';
import 'package:nazzbuzz/model/fav_model/fav_model.dart';
import 'package:nazzbuzz/utils/const.dart';



Future<void> addFavourite(SongInfo songs) async {
  globalController.favaroList.value.insert(0, songs);
  Box<Favmodel> favDb = await Hive.openBox<Favmodel>('Favaourites');
  Favmodel temp = Favmodel(id: songs.id);
  await favDb.add(temp);
  globalController.favaroList.notifyListeners();
}

getFAvourite() async {
  globalController.favaroList.value.clear();
  List<Favmodel> favSongCheck = [];
  final favDb = await Hive.openBox<Favmodel>('Favaourites');
  favSongCheck.addAll(favDb.values);
  for (var favs in favSongCheck) {
    int count = 0;
    for (var songs in globalController. allsongs) {
      if (favs.id == songs.id) {
        globalController.favaroList.value.add(songs);
        break;
      } else {
        count++;
      }
    }
    if (count ==globalController. allsongs.length) {
      var key = favs.key;
      favDb.delete(key);
    }
  }
  globalController.favaroList.notifyListeners();
}

removeFavourite(SongInfo song) async {
  globalController.favaroList.value.remove(song);
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
  globalController.favaroList.notifyListeners();
  getFAvourite();
}

clearFav() async {
 Box<Favmodel> favDb = await Hive.openBox<Favmodel>('Favaourites');
  await favDb.clear();
}
