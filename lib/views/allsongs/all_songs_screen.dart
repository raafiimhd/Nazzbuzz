import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nazzbuzz/controller/home_controller/home_screen_controller.dart';
import 'package:nazzbuzz/model/mostly_played_model/mostly_played.dart';
import 'package:nazzbuzz/model/recently_played_model/recent_model.dart';
import 'package:nazzbuzz/utils/color.dart';
import 'package:nazzbuzz/utils/const.dart';
import 'package:nazzbuzz/services/fav_db/fav_db.dart';
import 'package:nazzbuzz/services/recently_db/recently_db.dart';
import 'package:nazzbuzz/views/mini_player_screen/miniplayer.dart';
import 'package:nazzbuzz/views/playlist/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../services/mostly_played_db/mostly_played_db.dart';
import '../favourite_screen/widgets/fav_icon.dart';
import '../../utils/widgets/listtile_widget.dart';

class AllSongsScreen extends StatelessWidget {
  const AllSongsScreen(
      {super.key,
      required this.onFavouritePressed,
      required this.onPlaylistPressed});
  final TextButton onFavouritePressed;
  final TextButton onPlaylistPressed;
  @override
  Widget build(BuildContext context) {
    HomeGetxController homeController = Get.put(HomeGetxController());
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: globalController.allsongs.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                final song = globalController.allsongs[index];
                return InkWell(
                  onTap: () {
                    homeController.onSongClicked(index);
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
                          Get.to(MyList(idx: index));
                        }
                      },
                      icon: const Icon(
                        Icons.more_horiz_sharp,
                        color: kWhite
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
                                            builder: (ctx) =>
                                                MyList(idx: index)));
                                  },
                                  icon: const Icon(
                                    Icons.playlist_add,
                                    color: kBlack
                                  ),
                                  label: const Text(
                                    'Add to playlist',
                                    style: TextStyle(color: kBlack),
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
                                  icon: FavIcon(
                                    currentSong:
                                        globalController.allsongs[index],
                                    isFav: favaroList.value.contains(
                                      globalController.allsongs[index],
                                    ),
                                  ),
                                  label: const Text(
                                    'Favourite',
                                    style: TextStyle(color: kBlack),
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
                );
              },
            ),
          ),
        ),
        // Add the MiniPlayer widget here and conditionally show it
        globalController.isMiniPlayerVisible
            ? const MiniPlayer()
            : const SizedBox(),
      ],
    );
  }

  // Widget noAccessToLibraryWidget() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10),
  //       color: Colors.redAccent.withOpacity(0.5),
  //     ),
  //     padding: const EdgeInsets.all(20),
  //     child:const Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //          Text("Application doesn't have access to the library"),
  //          SizedBox(height: 10),
  //         // ElevatedButton(
  //         //   onPressed: widget.,
  //         //   child: const Text("Allow"),
  //         // ),
  //       ],
  //     ),
  //   );
  // }
}
