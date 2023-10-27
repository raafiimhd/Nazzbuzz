import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:nazzbuzz/model/allsongs_model/db_model.dart';
import 'package:nazzbuzz/utils/const.dart';

class NowPlayingController extends GetxController {
  bool isShuffleEnabled = false;
  bool isRepeatenabled = false;
  late SongInfo currentsong;

  double volume = 0.3;
  void setVolume(double value) {
    volume = value;
    update();
    globalController.player.setVolume(value);
  }

  void toggleShuffle() {
    isShuffleEnabled = !isShuffleEnabled;
    update();
  }

  void enableRepeat() {
    globalController.player.setLoopMode(LoopMode.single);
  }

  void skipForward(Duration duration) {
    globalController.player.seekBy(duration);
  }

  void skipBackward(Duration duration) {
    globalController.player.seekBy(-duration);
  }

  SongInfo? currentsongfinder(int id) {
    for (SongInfo song in globalController.allsongs) {
      if (id == song.id) {
        return song;
      }
    }
    return null;
  }

  void repeatFun() {
    enableRepeat();
    isRepeatenabled = !isRepeatenabled;
    update();
  }
}
