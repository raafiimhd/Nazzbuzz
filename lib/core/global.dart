import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:nazzbuzz/database/model/db_model.dart';
import 'package:nazzbuzz/database/model/playlist_model/playlist_model.dart';

final AssetsAudioPlayer player = AssetsAudioPlayer();
List<String> allfilePaths = [];
List<String?> artistNames = [];
List<String> songNames = [];
List<int> ids = [];
List<AppPlaylist> playlists = [];
List<SongInfo> allsongs=[];
bool isMiniPlayerVisible = false;