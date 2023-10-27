import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nazzbuzz/model/allsongs_model/db_model.dart';
import 'package:nazzbuzz/model/playlist_model/playlist_model.dart';


class GlobalStateController extends GetxController{
  bool isMiniPlayerVisible = true;
  final AssetsAudioPlayer player = AssetsAudioPlayer();
List<String> allfilePaths = [];
List<String?> artistNames = [];
List<String> songNames = [];
List<int> ids = [];
List<AppPlaylist> playlists = [];
List<SongInfo> allsongs=[];
late TabController tabController;
  
}