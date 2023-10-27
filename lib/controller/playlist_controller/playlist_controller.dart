import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nazzbuzz/model/allsongs_model/db_model.dart';
import 'package:nazzbuzz/model/playlist_model/playlist_model.dart';
import 'package:nazzbuzz/services/playlist_db/playlist_db.dart';
import 'package:nazzbuzz/utils/const.dart';

class PlaylistController extends GetxController {
   final RxList<AppPlaylist> playlists = <AppPlaylist>[].obs;
  void onSongClicked(int index, List<SongInfo> song) {
    globalController.player.stop();
    List<Audio> audiolist = [];
    for (int i = 0; i < song.length; i++) {
      audiolist.add(Audio.file(
        song[i].uri!,
        metas: Metas(
          title: song[i].title,
          artist: song[i].artist,
          id: song[i].id.toString(),
        ),
      ));
    }
    globalController.player
        .open(Playlist(audios: audiolist, startIndex: index));
  }

  void showAddPlaylistDialog(BuildContext context) {
    String playlistName = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Playlist'),
          content: TextField(
            onChanged: (value) {
              playlistName = value;
            },
            decoration: const InputDecoration(
              hintText: 'Enter playlist name',
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                addPlayList(playlistName);
                Get.back();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
  
}
