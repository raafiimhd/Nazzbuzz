import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nazzbuzz/model/recently_played_model/recent_model.dart';
import 'package:nazzbuzz/utils/const.dart';

class RecentlyPlayedController extends GetxController{
    List<RecentlyPlayed> recentSongs = [];

  void onSongClicked(int index) {
    globalController.player.stop();
    List<Audio> audiolist = [];
    for (int i = 0; i < recentSongs.length; i++) {
      audiolist.add(Audio.file(
        recentSongs[i].uri!,
        metas: Metas(
          title: recentSongs[i].title,
          artist: recentSongs[i].artist,
          id: recentSongs[i].id.toString(),
        ),
      ));
    }
    globalController.player
        .open(Playlist(audios: audiolist, startIndex: index));
  }
}