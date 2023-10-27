import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:nazzbuzz/services/mostly_played_db/mostly_played_db.dart';
import 'package:nazzbuzz/utils/const.dart';

class MostlyPlayedController extends GetxController {
  var mostlyPlayedSongs = sortMostlyPlayed();
  void onSongClicked(int index) {
    globalController.player.stop();
    List<Audio> audiolist = [];
    for (int i = 0; i < mostlyPlayedSongs.length; i++) {
      audiolist.add(Audio.file(
        mostlyPlayedSongs[i].uri!,
        metas: Metas(
          title: mostlyPlayedSongs[i].title,
          artist: mostlyPlayedSongs[i].artist,
          id: mostlyPlayedSongs[i].id.toString(),
        ),
      ));
    }
    globalController.player
        .open(Playlist(audios: audiolist, startIndex: index));
    globalController.isMiniPlayerVisible = true;
    update();
  }
}
