import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nazzbuzz/controller/mostly_played_controlller/mostly_played_controller.dart';
import 'package:nazzbuzz/model/recently_played_model/recent_model.dart';
import 'package:nazzbuzz/services/fav_db/fav_db.dart';
import 'package:nazzbuzz/services/mostly_played_db/mostly_played_db.dart';
import 'package:nazzbuzz/services/recently_db/recently_db.dart';
import 'package:nazzbuzz/utils/color.dart';
import 'package:nazzbuzz/utils/const.dart';
import 'package:nazzbuzz/views/mini_player_screen/miniplayer.dart';
import 'package:nazzbuzz/views/favourite_screen/widgets/fav_icon.dart';
import 'package:nazzbuzz/views/playlist/playlist.dart';
import 'package:nazzbuzz/utils/widgets/listtile_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MostlyPlayedScreen extends StatelessWidget {
  const MostlyPlayedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MostlyPlayedController mostlyPlayedController =
        Get.put(MostlyPlayedController());

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
            'MOSTLY PLAYED',
            style: TextStyle(color: kWhite),
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
                  return mostlyPlayedController.mostlyPlayedSongs.isNotEmpty
                      ? ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                mostlyPlayedController.onSongClicked(index);
                                updateRecentlyPlayed(RecentlyPlayed(
                                  id: globalController.allsongs[index].id,
                                  title: mostlyPlayedController
                                      .mostlyPlayedSongs[index].title,
                                  artist: mostlyPlayedController
                                      .mostlyPlayedSongs[index].artist,
                                  duration: mostlyPlayedController
                                      .mostlyPlayedSongs[index].duration,
                                  uri: mostlyPlayedController
                                      .mostlyPlayedSongs[index].uri,
                                ));
                              },
                              child: Listtile(
                                leading: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: QueryArtworkWidget(
                                    id: mostlyPlayedController
                                        .mostlyPlayedSongs[index].id!,
                                    type: ArtworkType.AUDIO,
                                    artworkFit: BoxFit.cover,
                                    nullArtworkWidget: Image.asset(
                                        'assets/images/images (3).jpg'),
                                  ),
                                ),
                                title: Text(
                                  mostlyPlayedController
                                      .mostlyPlayedSongs[index].title!,
                                  style: const TextStyle(
                                      color: kWhite,
                                      fontSize: 20,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                subtitle: Text(
                                    mostlyPlayedController
                                        .mostlyPlayedSongs[index].artist!,
                                    style: const TextStyle(
                                        color: kWhite,
                                        overflow: TextOverflow.ellipsis)),
                                trailing1: FavIcon(
                                  currentSong: globalController.allsongs[index],
                                  isFav: globalController.favaroList.value.contains(
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
                                    const PopupMenuItem(
                                      value: 0,
                                      child: Row(
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
                          itemCount:
                              mostlyPlayedController.mostlyPlayedSongs.length)
                      : const Center(
                          child: Text(
                            'Mostly played is empty',
                            style: TextStyle(color: kWhite, fontSize: 20),
                          ),
                        );
                }),
          ),
          globalController.isMiniPlayerVisible
              ? const MiniPlayer()
              : const SizedBox()
        ],
      )),
    );
  }
}
