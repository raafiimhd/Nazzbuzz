import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nazzbuzz/database/functions/fav_db.dart';
import 'package:nazzbuzz/database/functions/mostly_playeddb.dart';
import 'package:nazzbuzz/database/model/recent_model.dart';
import 'package:nazzbuzz/mini+now_play.dart/miniplayer.dart';
import 'package:nazzbuzz/library/favourite/fav_icon.dart';
import 'package:nazzbuzz/playlist/playlist.dart';
import 'package:nazzbuzz/widgets/listtile_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../core/global.dart';
import '../database/functions/recently_db.dart';

var mostlyPlayedSongs = sortMostlyPlayed();

class MostlyPlayedScreen extends StatefulWidget {
  const MostlyPlayedScreen({super.key});

  @override
  State<MostlyPlayedScreen> createState() => _MostlyPlayedScreenState();
}

class _MostlyPlayedScreenState extends State<MostlyPlayedScreen> {
  @override
  Widget build(BuildContext context) {
    mostlyPlayedSongs = sortMostlyPlayed();
    void onSongClicked(int index) {
      player.stop();
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
      player.open(Playlist(audios: audiolist, startIndex: index));

      setState(() {
        isMiniPlayerVisible = true;
      });
    }

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
            'MOSTLY PLAYED',
            style: TextStyle(color: Colors.white),
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
                                clearMostly();
                              },
                              child: const Text('Clear mostlyPlayed'))),
                    ])
          ]),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: mostlyPlayedDb.listenable(),
                builder: (context, value, child) {
                  return mostlyPlayedSongs.isNotEmpty
                      ? ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                onSongClicked(index);
                                updateRecentlyPlayed(RecentlyPlayed(
                                  id: allsongs[index].id,
                                  title: mostlyPlayedSongs[index].title,
                                  artist: mostlyPlayedSongs[index].artist,
                                  duration: mostlyPlayedSongs[index].duration,
                                  uri: mostlyPlayedSongs[index].uri,
                                ));
                              },
                              child: Listtile(
                                leading: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: QueryArtworkWidget(
                                    id: mostlyPlayedSongs[index].id!,
                                    type: ArtworkType.AUDIO,
                                    artworkFit: BoxFit.cover,
                                    nullArtworkWidget: Image.asset(
                                        'assets/images/images (3).jpg'),
                                  ),
                                ),
                                title: Text(
                                  mostlyPlayedSongs[index].title!,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                subtitle: Text(mostlyPlayedSongs[index].artist!,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis)),
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
                                            builder: (ctx) => MyList(
                                                  idx: index,
                                                )),
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
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                context: context,
                                index: index,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 4,
                            );
                          },
                          itemCount: mostlyPlayedSongs.length)
                      : const Center(
                          child: Text(
                            'Mostly played is empty',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        );
                }),
          ),
          isMiniPlayerVisible ? const MiniPlayer() : const SizedBox()
        ],
      )),
    );
  }
}
