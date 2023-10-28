import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nazzbuzz/model/allsongs_model/db_model.dart';
import 'package:nazzbuzz/model/playlist_model/playlist_model.dart';
import 'package:nazzbuzz/model/playlist_model/uniquelist.dart';
import 'package:nazzbuzz/utils/const.dart';

// ----playlistBodyNotifier for rebuilding the playlist body
ValueNotifier<List<UniqueList>> playListNotifier = ValueNotifier([]);

List name = [];

Future<void> addPlayList(String name) async {
  playListNotifier.value.add(UniqueList(name: name));
  Box<AppPlaylist> playlistDb = await Hive.openBox<AppPlaylist>('playlists');
  playlistDb.add(AppPlaylist(playlistName: name));
  playlistDb.close();
  playListNotifier.notifyListeners();
}

Future playlistdelete(int index) async {
  String playListname = playListNotifier.value[index].name;
  Box<AppPlaylist> playlistdb = await Hive.openBox<AppPlaylist>('playlists');
  for (var element in playlistdb.values) {
    if (element.playlistName == playListname) {
      var key = element.key;
      playlistdb.delete(key);
      break;
    }
  }
  playListNotifier.value.removeAt(index);
  playListNotifier.notifyListeners();
}

// playlistdbListclear() async {
//   Box<AppPlaylist> playlistdb = await Hive.openBox<AppPlaylist>('playlists');
//   for (var element in playlistdb.values) {
//     element.items.clear();
//   }
// }

Future<void> playlistAddDB(SongInfo addingSong, String playListName) async {
  Box<AppPlaylist> playlistdb = await Hive.openBox<AppPlaylist>('playlists');
  for (var element in playlistdb.values) {
    if (element.playlistName == playListName) {
      var key = element.key;
      AppPlaylist updatePlaylist = AppPlaylist(playlistName: playListName);
      updatePlaylist.items.addAll(element.items);
      if (!updatePlaylist.items.contains(addingSong.id)) {
        updatePlaylist.items.add(addingSong.id!);
      }
      playlistdb.put(key, updatePlaylist);
      break;
    }
  }
  for (int i = 0; i < playListNotifier.value.length; i++) {
    if (playListName == playListNotifier.value[i].name) {
      if (!playListNotifier.value[i].container.contains(addingSong)) {
        playListNotifier.value[i].container.add(addingSong);
      }
    }
  }
  playListNotifier.notifyListeners();
}

Future playListSongDelete(SongInfo removingSong, String playListName) async {
  Box<AppPlaylist> playlistdb = await Hive.openBox<AppPlaylist>('playlists');
  for (var element in playlistdb.values) {
    if (element.playlistName == playListName) {
      var key = element.key;
      AppPlaylist ubdatePlaylist = AppPlaylist(playlistName: playListName);
      for (var item in element.items) {
        if (item == removingSong.id) {
          continue;
        }
        ubdatePlaylist.items.add(item);
      }
      playlistdb.put(key, ubdatePlaylist);
      break;
    }
  }
  playListNotifier.notifyListeners();
}

Future playlistrename(int index, String newname) async {
  String playListname = playListNotifier.value[index].name;
  Box<AppPlaylist> playlistdb = await Hive.openBox<AppPlaylist>('playlists');
  for (var element in playlistdb.values) {
    if (element.playlistName == playListname) {
      var key = element.key;
      element.playlistName = newname;
      playlistdb.put(key, element);
    }
  }
  playListNotifier.value[index].name = newname;
  playListNotifier.notifyListeners();
}

getplayList() async {
  playListNotifier.value.clear();
  List<AppPlaylist> playlistSongcheck = [];
  Box<AppPlaylist> playlistdb = await Hive.openBox<AppPlaylist>('playlists');
  log('aaaaaaaaaaaaaaaaaaaaaaaaaaa${playlistdb.values.length}');
  for (AppPlaylist elements in playlistdb.values) {
    String playListname = elements.playlistName;
    UniqueList getplayList = UniqueList(name: playListname);
    for (int id in elements.items) {
      for (SongInfo songs in globalController. allsongs) {
        if (id == songs.id) {
          getplayList.container.add(songs);
          break;
        }
      }
    }
    playListNotifier.value.add(getplayList);
    playListNotifier.notifyListeners();
  }
}

playlistClear() async {
  Box<AppPlaylist> playlistDb = await Hive.openBox<AppPlaylist>('playlists');
  playlistDb.clear();
}
