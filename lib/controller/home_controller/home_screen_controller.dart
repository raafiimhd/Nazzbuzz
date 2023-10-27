import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nazzbuzz/utils/const.dart';

class HomeGetxController extends GetxController
    with GetSingleTickerProviderStateMixin {
  bool isShuffleEnabled = false;
  
  void toggleShuffle() {
    isShuffleEnabled = !isShuffleEnabled;
    update();
  }

  void onSongClicked(int index) {
    globalController.player.stop();
    List<Audio> audiolist = [];
    for (int i = 0; i < globalController.allsongs.length; i++) {
      audiolist.add(Audio.file(
        globalController.allsongs[i].uri!,
        metas: Metas(
          title: globalController.allsongs[i].title,
          artist: globalController.allsongs[i].artist,
          id: globalController.allsongs[i].id.toString(),
        ),
      ));
    }
    globalController.player
        .open(Playlist(audios: audiolist, startIndex: index));
  }

  RxInt currentTabIndex = 0.obs;

  List<Tab> myTab = [
    const Tab(
      child: Text(
        'SONGS',
        style: TextStyle(color: Colors.white),
      ),
    ),
    const Tab(
      child: Text(
        'LIBRARY',
        style: TextStyle(color: Colors.white),
      ),
    ),
  ];
  @override
  void onInit() {
    super.onInit();
    globalController. tabController = TabController(
      vsync: this,
      length: myTab.length,
    );
   globalController. tabController.animateTo(currentTabIndex.value);
  }

  @override
  void onClose() {
    globalController.tabController.dispose();
    super.onClose();
  }

  void handleTabSelection(int index) {
    currentTabIndex.value = index;
    update();
  }
}
