import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nazzbuzz/model/allsongs_model/db_model.dart';
import 'package:nazzbuzz/model/mostly_played_model/mostly_played.dart';
import 'package:nazzbuzz/model/recently_played_model/recent_model.dart';
import 'package:nazzbuzz/utils/color.dart';
import 'package:nazzbuzz/utils/const.dart';
import 'package:nazzbuzz/services/fav_db/fav_db.dart';
import 'package:nazzbuzz/services/recently_db/recently_db.dart';
import 'package:nazzbuzz/views/mini_player_screen/miniplayer.dart';
import 'package:nazzbuzz/views/favourite_screen/widgets/fav_icon.dart';
import 'package:nazzbuzz/views/playlist/playlist.dart';
import 'package:nazzbuzz/utils/widgets/listtile_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../services/mostly_played_db/mostly_played_db.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({
    Key? key,
  }) : super(key: key);

  void onSongClicked(int index) {
    globalController.player.stop();
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
    globalController.player
        .open(Playlist(audios: audiolist, startIndex: index));
  }

  @override
  Widget build(BuildContext context) {
    getFAvourite();
    return Scaffold(
      backgroundColor: kBlack,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: kBlack,
        title: const Text(
          'Favourites',
          style: TextStyle(
            color: kWhite,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios, color: kWhite),
        ),
        actions: [
          PopupMenuButton(
              icon: const Icon(Icons.more_vert, color: kWhite),
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
          globalController.isMiniPlayerVisible
              ? const MiniPlayer()
              : const SizedBox(),
        ],
      ),
    );
  }

  Center noSong() {
    return const Center(
      child: Text(
        'Favourite is empty',
        style: TextStyle(fontFamily: 'Peddana', fontSize: 14, color: kWhite),
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
                id: globalController.allsongs[index].id,
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
                style: const TextStyle(color: kWhite),
              ),
              subtitle: Text(
                song.artist ?? 'unknown',
                style: const TextStyle(color: kWhite),
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
              trailing1: FavIcon(
                currentSong: song,
                isFav: favaroList.value.contains(song),
              ),
              trailing2: PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onSelected: (value) {
                  if (value == 0) {
                    Get.to(MyList(idx: index));
                  }
                },
                icon: const FaIcon(
                  FontAwesomeIcons.ellipsisVertical,
                  color: kWhite,
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
                          color: kBlack,
                        ),
                        Text(
                          'Add to playlist',
                          style: TextStyle(color: kBlack),
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
