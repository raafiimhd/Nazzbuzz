import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nazzbuzz/core/global.dart';
import 'package:nazzbuzz/database/functions/fav_db.dart';
import 'package:nazzbuzz/database/functions/recently_db.dart';
import 'package:nazzbuzz/database/model/db_model.dart';
import 'package:nazzbuzz/mini+now_play.dart/miniplayer.dart';
import 'package:nazzbuzz/library/favourite/fav_icon.dart';
import 'package:nazzbuzz/playlist/playlist.dart';
import 'package:nazzbuzz/widgets/listtile_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../database/functions/mostly_playeddb.dart';
import '../../database/model/mostly_played.dart';
import '../../database/model/recent_model.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  bool isMiniPlayerVisible = false;
  void onSongClicked(int index) {
    player.stop();
    List<Audio> audiolist = [];
    for (int i = 0; i < favaroList.value.length; i++) {
      audiolist.add(Audio.file(
        favaroList.value[i].uri.toString(),
        metas: Metas(
          title: favaroList.value[i].title,
          artist: favaroList.value[i].artist,
          id: favaroList.value[i].id.toString(),
        ),
      ));
    }
    player.open(Playlist(audios: audiolist, startIndex: index));

    setState(() {
      isMiniPlayerVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    getFAvourite();
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Favourites',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
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
                              clearFav();
                            },
                            child: const Text('Clear Favourite songs'))),
                  ])
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 9.0, right: 9),
              child: ValueListenableBuilder(
                valueListenable: favaroList,
                builder: (context, value, child) => (favaroList.value.isEmpty)
                    ? noSong()
                    : favouriteBuilderFunction(),
              ),
            ),
          ),
          if (isMiniPlayerVisible) const MiniPlayer(),
        ],
      ),
    );
  }

  Center noSong() {
    return const Center(
      child: Text(
        'Favourite is empty',
        style:
            TextStyle(fontFamily: 'Peddana', fontSize: 14, color: Colors.white),
      ),
    );
  }

  Widget favouriteBuilderFunction() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        SongInfo song = favaroList.value[index];
        return Padding(
          padding: const EdgeInsets.only(top: 20),
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
            // onTap: () {
            //   showBottomSheet(
            //     context: context,
            //     builder: ((context) => const MiniPlayer()),
            //   );
            // },
            child: Listtile(
              context: context,
              index: index,
              title: Text(
                song.title!,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                song.artist ?? 'unknown',
                style: const TextStyle(color: Colors.white),
              ),
              leading: QueryArtworkWidget(
                artworkFit: BoxFit.cover,
                id: song.id!,
                type: ArtworkType.AUDIO,
                nullArtworkWidget: ClipRRect(
                  borderRadius: BorderRadius.circular(27),
                  child: Image.asset(
                    'assets/images/images (3).jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              trailing1: favIcon(
                currentSong: song,
                isfav: favaroList.value.contains(song),
              ),
              trailing2: PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onSelected: (value) {
                  if (value == 0) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) =>MyList(idx: index)
                      ),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.playlist_add,
                          color: Colors.black,
                        ),
                        Text(
                          'Add to playlist',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: favaroList.value.length,
    );
  }
}
