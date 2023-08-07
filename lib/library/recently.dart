import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nazzbuzz/database/functions/fav_db.dart';
import 'package:nazzbuzz/database/functions/recently_db.dart';
import 'package:nazzbuzz/mini+now_play.dart/miniplayer.dart';
import 'package:nazzbuzz/library/favourite/fav_icon.dart';
import 'package:nazzbuzz/playlist/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../core/global.dart';
import '../database/functions/mostly_playeddb.dart';
import '../database/model/mostly_played.dart';
import '../database/model/recent_model.dart';
import '../widgets/listtile_widget.dart';

class Recently extends StatefulWidget {
  const Recently({super.key});

  @override
  State<Recently> createState() => _RecentlyState();
}

class _RecentlyState extends State<Recently> {
  List<RecentlyPlayed> recentSongs = [];
  void onSongClicked(int index) {
    player.stop();
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
    player.open(Playlist(audios: audiolist, startIndex: index));

    setState(() {
      isMiniPlayerVisible = true;
    });
  }

  bool isMiniPlayerVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: const Text(
            'Recently played',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            PopupMenuButton(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                itemBuilder: (context) => [
                      PopupMenuItem(
                          value: 1,
                          child: TextButton(
                              onPressed: () {
                                clearRecently();
                              },
                              child: const Text('Clear Recently played'))),
                    ])
          ]),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: recentlyPlayedDb.listenable(),
              builder:
                  (BuildContext context, Box<RecentlyPlayed> list, Widget? _) {
                recentSongs = list.values.toList().reversed.toList();
                return recentSongs.isNotEmpty
                    ? ListView.separated(
                        itemBuilder: (BuildContext context, index) {
                          bool isContains = allsongs
                              .where((element) =>
                                  element.id == recentSongs[index].id)
                              .isNotEmpty;
                          return isContains
                              ? InkWell(
                                  onTap: () {
                                    onSongClicked(index);
                                    addMostlyPlayedSong(MostlyPlayed(
                                        title: recentSongs[index].title,
                                        artist: recentSongs[index].artist,
                                        duration: recentSongs[index].duration,
                                        id: recentSongs[index].id,
                                        uri: recentSongs[index].uri));
                                  },
                                  child: Listtile(
                                    context: context,
                                    index: index,
                                    leading: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: QueryArtworkWidget(
                                        id: recentSongs[index].id!,
                                        type: ArtworkType.AUDIO,
                                        artworkFit: BoxFit.cover,
                                        nullArtworkWidget: Image.asset(
                                            'assets/images/images (3).jpg'),
                                      ),
                                    ),
                                    title: Text(
                                      recentSongs[index].title!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    subtitle: Text(
                                      recentSongs[index].artist!,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing1: favIcon(
                                      currentSong: allsongs[index],
                                      isfav: favaroList.value
                                          .contains(allsongs[index]),
                                    ),
                                    trailing2: PopupMenuButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      onSelected: (value) {
                                        if (value == 0) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    MyList(idx: index)),
                                          );
                                        }
                                      },
                                      icon: const FaIcon(
                                        FontAwesomeIcons.ellipsisVertical,
                                        color: Colors.white,
                                        size: 26,
                                      ),
                                      itemBuilder: (context) => [
                                        const PopupMenuItem(
                                          value: 0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Icon(
                                                Icons.playlist_add,
                                                color: Colors.black,
                                              ),
                                              Text(
                                                'Add to playlist',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink();
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 4,
                          );
                        },
                        itemCount: recentSongs.length)
                    : const Center(
                        child: Text(
                          'Recent is empty',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      );
              },
            ),
          ),
          isMiniPlayerVisible ? const MiniPlayer() : const SizedBox(),
        ],
      )),
    );
  }
}
