import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nazzbuzz/controller/recently_played_controller/recently_played_controller.dart';
import 'package:nazzbuzz/model/mostly_played_model/mostly_played.dart';
import 'package:nazzbuzz/model/recently_played_model/recent_model.dart';
import 'package:nazzbuzz/services/fav_db/fav_db.dart';
import 'package:nazzbuzz/services/mostly_played_db/mostly_played_db.dart';
import 'package:nazzbuzz/services/recently_db/recently_db.dart';
import 'package:nazzbuzz/utils/color.dart';
import 'package:nazzbuzz/utils/const.dart';
import 'package:nazzbuzz/utils/widgets/listtile_widget.dart';
import 'package:nazzbuzz/views/mini_player_screen/miniplayer.dart';
import 'package:nazzbuzz/views/favourite_screen/widgets/fav_icon.dart';
import 'package:nazzbuzz/views/playlist/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Recently extends StatelessWidget {
  const Recently({super.key});

  @override
  Widget build(BuildContext context) {
    RecentlyPlayedController recentController =
        Get.put(RecentlyPlayedController());
    return Scaffold(
      backgroundColor: kBlack,
      appBar: AppBar(
          backgroundColor: kBlack,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kWhite,
            ),
          ),
          title: const Text(
            'Recently played',
            style: TextStyle(
              color: kWhite,
            ),
          ),
          actions: [
            PopupMenuButton(
                icon: const Icon(
                  Icons.more_vert,
                  color: kWhite,
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
                recentController. recentSongs = list.values.toList().reversed.toList();
                return recentController.recentSongs.isNotEmpty
                    ? ListView.separated(
                        itemBuilder: (BuildContext context, index) {
                          bool isContains = globalController.allsongs
                              .where((element) =>
                                  element.id == recentController.recentSongs[index].id)
                              .isNotEmpty;
                          return isContains
                              ? InkWell(
                                  onTap: () {
                                   recentController. onSongClicked(index);
                                    addMostlyPlayedSong(MostlyPlayed(
                                        title:recentController. recentSongs[index].title,
                                        artist:recentController. recentSongs[index].artist,
                                        duration:recentController. recentSongs[index].duration,
                                        id:recentController. recentSongs[index].id,
                                        uri:recentController. recentSongs[index].uri));
                                  },
                                  child: Listtile(
                                    context: context,
                                    index: index,
                                    leading: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: QueryArtworkWidget(
                                        id: recentController.recentSongs[index].id!,
                                        type: ArtworkType.AUDIO,
                                        artworkFit: BoxFit.cover,
                                        nullArtworkWidget: Image.asset(
                                            'assets/images/images (3).jpg'),
                                      ),
                                    ),
                                    title: Text(
                                      recentController.recentSongs[index].title!,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: kWhite,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    subtitle: Text(
                                     recentController. recentSongs[index].artist!,
                                      style: const TextStyle(color: kWhite),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing1: FavIcon(
                                      currentSong:
                                          globalController.allsongs[index],
                                      isFav: favaroList.value.contains(
                                          globalController.allsongs[index]),
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
                                         PopupMenuItem(
                                          value: 0,
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                          onTap: () => globalController.tabController.animateTo(1),
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
                        itemCount: recentController.recentSongs.length)
                    : const Center(
                        child: Text(
                          'Recent is empty',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: kWhite),
                        ),
                      );
              },
            ),
          ),
          globalController.isMiniPlayerVisible
              ? const MiniPlayer()
              : const SizedBox(),
        ],
      )),
    );
  }
}
