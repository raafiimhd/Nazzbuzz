import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:nazzbuzz/core/global.dart';
import 'package:nazzbuzz/database/functions/fav_db.dart';
import 'package:nazzbuzz/database/functions/recently_db.dart';
import 'package:nazzbuzz/database/model/mostly_played.dart';
import 'package:nazzbuzz/database/model/recent_model.dart';
import 'package:nazzbuzz/mini+now_play.dart/miniplayer.dart';
import 'package:nazzbuzz/playlist/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../database/functions/mostly_playeddb.dart';
import '../database/model/db_model.dart';
import '../library/favourite/fav_icon.dart';
import '../widgets/listtile_widget.dart';

bool miniPlayerindex = false;
int songNameindex = 0;

class Mainpage1Content extends StatefulWidget {
  late final Function() onFavouritePressed;
  late final Function() onPlaylistPressed;

  Mainpage1Content({
    required this.onFavouritePressed,
    required this.onPlaylistPressed,
  });

  @override
  State<Mainpage1Content> createState() => _Mainpage1ContentState();
}

class _Mainpage1ContentState extends State<Mainpage1Content> {
  List<SongInfo> favoriteSongs = []; // List to hold favorite songs

  bool isPlaying = false;
  bool isPlaying1 = false;

  bool isMiniPlayerVisible = true;

  void onSongClicked(int index) {
    player.stop();
    List<Audio> audiolist = [];
    for (int i = 0; i < allsongs.length; i++) {
      audiolist.add(Audio.file(
        allsongs[i].uri!,
        metas: Metas(
          title: allsongs[i].title,
          artist: allsongs[i].artist,
          id: allsongs[i].id.toString(),
        ),
      ));
    }
    player.open(Playlist(audios: audiolist, startIndex: index));

    isMiniPlayerVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: allsongs.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 4),
              itemBuilder: (BuildContext context, int index) {
                final song = allsongs[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      onSongClicked(index);
                      addMostlyPlayedSong(MostlyPlayed(
                          title: song.title,
                          artist: song.artist,
                          duration: song.duration,
                          id: song.id,
                          uri: song.uri));
                      updateRecentlyPlayed(RecentlyPlayed(
                        id: allsongs[index].id,
                        title: song.title,
                        artist: song.artist,
                        duration: song.duration,
                        uri: song.uri,
                      ));
                    },
                    child: Listtile(
                      index: index,
                      context: context,
                      title: Text(
                        song.title!,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        song.artist ?? "No Artist",
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing1: PopupMenuButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onSelected: (value) {
                          if (value == 0) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => MyList(idx: index)
                              ),
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.more_horiz_sharp,
                          color: Colors.white,
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton.icon(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) =>MyList(idx: index) ));
                                    },
                                    icon: const Icon(
                                      Icons.playlist_add,
                                      color: Colors.black,
                                    ),
                                    label: const Text(
                                      'Add to playlist',
                                      style: TextStyle(color: Colors.black),
                                    ))
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton.icon(
                                    onPressed: () {},
                                    icon: favIcon(
                                      currentSong: allsongs[index],
                                      isfav: favaroList.value.contains(
                                        allsongs[index],
                                      ),
                                    ),
                                    label: const Text(
                                      'Favourite',
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      leading: QueryArtworkWidget(
                        id: song.id!,
                        nullArtworkWidget: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/images (3).jpg'),
                        ),
                        type: ArtworkType.AUDIO,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        // Add the MiniPlayer widget here and conditionally show it
        isMiniPlayerVisible ? const MiniPlayer() : const SizedBox(),
      ],
    );
  }

  Widget noAccessToLibraryWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.redAccent.withOpacity(0.5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Application doesn't have access to the library"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: widget.onFavouritePressed,
            child: const Text("Allow"),
          ),
        ],
      ),
    );
  }
}
