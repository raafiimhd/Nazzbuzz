import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:nazzbuzz/core/global.dart';
import 'package:nazzbuzz/database/functions/fav_db.dart';
import 'package:nazzbuzz/database/model/db_model.dart';
import 'package:nazzbuzz/database/model/mostly_played.dart';
import 'package:nazzbuzz/mini+now_play.dart/miniplayer.dart';
import 'package:nazzbuzz/library/favourite/fav_icon.dart';
import 'package:nazzbuzz/playlist/platlist_bottom.dart';
import 'package:nazzbuzz/widgets/listtile_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../database/functions/mostly_playeddb.dart';
import '../database/functions/playlist_db.dart';
import '../database/functions/recently_db.dart';
import '../database/model/recent_model.dart';

class ListingScreen extends StatefulWidget {
  String playlistName;

  int idx;
  ListingScreen({super.key, required this.playlistName, required this.idx});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  @override
  Widget build(BuildContext ctx) {
    getplayList();
    void onSongClicked(int index, List<SongInfo> song) {
      player.stop();
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
      player.open(Playlist(audios: audiolist, startIndex: index));

      setState(() {
        isMiniPlayerVisible = true;
      });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                Text(
                  widget.playlistName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () => showModalBottomSheet(
                          context: ctx,
                          builder: (context) => PlaylistBottomSheet(
                              playlistName: widget.playlistName,
                              idx: widget.idx),
                        ),
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ))
              ],
            ),
            
            Expanded(
              child: InkWell(
                child: ValueListenableBuilder(
                  valueListenable: playListNotifier,
                  builder: (context, value, child) {
                    return value.isEmpty
                        ? CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.all(12),
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      onSongClicked(
                                          index, value[widget.idx].container);

                                      addMostlyPlayedSong(MostlyPlayed(
                                          title: value[widget.idx].container[index].title,
                                          artist:  value[widget.idx].container[index].artist,
                                          duration:  value[widget.idx].container[index].duration,
                                          id:  value[widget.idx].container[index].id,
                                          uri:  value[widget.idx].container[index].uri));
                                      updateRecentlyPlayed(RecentlyPlayed(
                                        id:  value[widget.idx].container[index].id,
                                        title:  value[widget.idx].container[index].title,
                                        artist:  value[widget.idx].container[index].artist,
                                        duration:  value[widget.idx].container[index].duration,
                                        uri:  value[widget.idx].container[index].uri,
                                      ));
                                    },
                                    child: Listtile(
                                      context: context,
                                      index: index,
                                      leading: SizedBox(
                                        child: ClipOval(
                                          child: QueryArtworkWidget(
                                            id: value[widget.idx]
                                                .container[index]
                                                .id!,
                                            type: ArtworkType.AUDIO,
                                            artworkFit: BoxFit.cover,
                                            nullArtworkWidget: Image.asset(
                                              'assets/images/images (3).jpg',
                                              fit: BoxFit.cover,
                                              // Add the package name if necessary
                                            ),
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        value[widget.idx]
                                            .container[index]
                                            .title!,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      subtitle: Text(value[widget.idx]
                                          .container[index]
                                          .artist!),
                                      trailing1: favIcon(
                                        currentSong:
                                            value[widget.idx].container[index],
                                        isfav: favaroList.value.contains(
                                            value[widget.idx].container[index]),
                                      ),
                                      trailing2: IconButton(
                                        onPressed: () {
                                          playListSongDelete(
                                              value[widget.idx]
                                                  .container[index],
                                              widget.playlistName);
                                          playListNotifier
                                              .value[widget.idx].container
                                              .remove(value[widget.idx]
                                                  .container[index]);
                                        },
                                        icon: const Icon(
                                          Icons.playlist_remove,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 6),
                                itemCount: value[widget.idx].container.length),
                          );
                  },
                ),
              ),
            ),
            isMiniPlayerVisible ? const MiniPlayer() : const SizedBox(),
          ],
        ),
      )),
    );
  }
}
