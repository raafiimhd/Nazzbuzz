import 'dart:async';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:nazzbuzz/model/allsongs_model/db_model.dart';
import 'package:nazzbuzz/views/home/home_screen.dart';
import 'package:nazzbuzz/utils/const.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SplashScreenController extends GetxController {
  bool hasPermission = false;
  final OnAudioQuery _audioQuery = OnAudioQuery();
   SongInfo? song;
  @override
  void onInit() {
    super.onInit();
    checkAndRequestPermissions();
  }

  Future<void> checkAndRequestPermissions({bool retry = false}) async {
    hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );
    if (hasPermission) {
      final allsongsDb = Hive.box<SongInfo>('all Songs');
      if (allsongsDb.values.isEmpty) {
        await fetchSongsfromstorage();
      } else {
        globalController.allsongs = allsongsDb.values.toList();
      }

      update();
      navigateToHomeScreen();
    } else {
      // Handle the case when permission is not granted
      // You can show an error message or take appropriate action.
    }
  }

  Future<void> fetchSongsfromstorage() async {
    final allsongDb = Hive.box<SongInfo>('all Songs');
    List<SongModel> templist = await _audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    for (SongModel song in templist) {
      if (song.fileExtension == "mp3") {
        SongInfo songInfo = SongInfo(
          title: song.displayNameWOExt,
          artist: song.artist,
          id: song.id,
          duration: song.duration,
          uri: song.uri,
        );
        globalController.allsongs.add(songInfo);
        allsongDb.add(songInfo);
      }
    }
  }

  Future<void> navigateToHomeScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    Timer(const Duration(seconds: 2), () {
      Get.off(const HomeScreen(
        initialTabIndex: 0,
      ));
    });
  }
}
