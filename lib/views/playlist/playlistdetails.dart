import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nazzbuzz/controller/playlist_controller/playlist_controller.dart';
import 'package:nazzbuzz/model/mostly_played_model/mostly_played.dart';
import 'package:nazzbuzz/model/recently_played_model/recent_model.dart';
import 'package:nazzbuzz/services/fav_db/fav_db.dart';
import 'package:nazzbuzz/services/mostly_played_db/mostly_played_db.dart';
import 'package:nazzbuzz/services/playlist_db/playlist_db.dart';
import 'package:nazzbuzz/services/recently_db/recently_db.dart';
import 'package:nazzbuzz/utils/color.dart';
import 'package:nazzbuzz/utils/const.dart';
import 'package:nazzbuzz/views/mini_player_screen/miniplayer.dart';
import 'package:nazzbuzz/views/favourite_screen/widgets/fav_icon.dart';
import 'package:nazzbuzz/views/playlist/playlist_addsong/playlist_add_song_screen.dart';
import 'package:nazzbuzz/utils/widgets/listtile_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';



class ListingScreen extends StatelessWidget {
  String playlistName;

  int idx;
  ListingScreen({super.key, required this.playlistName, required this.idx});

  @override
  Widget build(BuildContext context) {
    PlaylistController playlistController = Get.put(PlaylistController());
    return Scaffold(
      backgroundColor: kBlack,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: kWhite,
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                Text(
                  playlistName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: kWhite),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () => showModalBottomSheet(
                          context: context,
                          builder: (context) => PlaylistBottomSheet(
                              playlistName: playlistName, idx: idx),
                        ),
                    icon: const Icon(
                      Icons.add,
                      color: kWhite,
                    ))
              ],
            ),
            Expanded(
              child: InkWell(
                child: ValueListenableBuilder(
                  valueListenable: playListNotifier,
                  builder: (context, value, child) {
                    return value.isEmpty
                        ? const CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.all(12),
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                     playlistController. onSongClicked(
                                          index, value[idx].container);

                                      addMostlyPlayedSong(MostlyPlayed(
                                          title:
                                              value[idx].container[index].title,
                                          artist: value[idx]
                                              .container[index]
                                              .artist,
                                          duration: value[idx]
                                              .container[index]
                                              .duration,
                                          id: value[idx].container[index].id,
                                          uri:
                                              value[idx].container[index].uri));
                                      updateRecentlyPlayed(RecentlyPlayed(
                                        id: value[idx].container[index].id,
                                        title:
                                            value[idx].container[index].title,
                                        artist:
                                            value[idx].container[index].artist,
                                        duration: value[idx]
                                            .container[index]
                                            .duration,
                                        uri: value[idx].container[index].uri,
                                      ));
                                    },
                                    child: Listtile(
                                      context: context,
                                      index: index,
                                      leading: SizedBox(
                                        child: ClipOval(
                                          child: QueryArtworkWidget(
                                            id: value[idx].container[index].id!,
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
                                        value[idx].container[index].title!,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      subtitle: Text(
                                          value[idx].container[index].artist!),
                                      trailing1: FavIcon(
                                        currentSong:
                                            value[idx].container[index],
                                        isFav: globalController.favaroList.value.contains(
                                            value[idx].container[index]),
                                      ),
                                      trailing2: IconButton(
                                        onPressed: () {
                                          playListSongDelete(
                                              value[idx].container[index],
                                              playlistName);
                                          playListNotifier.value[idx].container
                                              .remove(
                                                  value[idx].container[index]);
                                        },
                                        icon: const Icon(
                                          Icons.playlist_remove,
                                          color: kWhite
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 6),
                                itemCount: value[idx].container.length),
                          );
                  },
                ),
              ),
            ),
            globalController.isMiniPlayerVisible
                ? const MiniPlayer()
                : const SizedBox(),
          ],
        ),
      )),
    );
  }
}
