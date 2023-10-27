import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nazzbuzz/model/allsongs_model/db_model.dart';
import 'package:nazzbuzz/services/fav_db/fav_db.dart';
import 'package:nazzbuzz/utils/const.dart';
import 'package:nazzbuzz/views/favourite_screen/widgets/fav_icon.dart';
import 'package:nazzbuzz/views/playlist/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchControllerT extends GetxController {
  ValueNotifier<List<SongInfo>> searchdata = ValueNotifier([]);
  bool isCloseButtonVisible = false;

  TextEditingController searchEditingController = TextEditingController();
  void onSongClicked(int index) {
    globalController.player.stop();
    List<Audio> audiolist = [];
    for (int i = 0; i < searchdata.value.length; i++) {
      audiolist.add(Audio.file(
        searchdata.value[i].uri!,
        metas: Metas(
          title: searchdata.value[i].title,
          artist: searchdata.value[i].artist,
          id: searchdata.value[i].id.toString(),
        ),
      ));
    }
    globalController.player
        .open(Playlist(audios: audiolist, startIndex: index));
  }

  void onSongClickedFun(int index) {
    globalController.player.stop();
    List<Audio> audiolist = [];
    for (int i = 0; i < globalController.allsongs.length; i++) {
      audiolist.add(Audio.file(
        globalController.allsongs[i].uri!,
        metas: Metas(
          title: globalController.allsongs[i].title,
          artist: globalController.allsongs[i].artist,
          id: globalController.allsongs[i].id.toString(),
        ),
      ));
    }
    globalController.player
        .open(Playlist(audios: audiolist, startIndex: index));
  }

  clearText(context) {
    if (searchEditingController.text.isNotEmpty) {
      searchEditingController.clear();
      searchdata.notifyListeners();
    } else {
      Navigator.of(context).pop();
    }
  }

  Widget searchFound(BuildContext ctx) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            onSongClicked(index);
          },
          child: ListTile(
            textColor: Colors.white,
            trailing: PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) {
                if (value == 0) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => MyList(idx: index)),
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
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FavIcon(
                        currentSong: searchdata.value[index],
                        isFav: favaroList.value.contains(
                          searchdata.value[index],
                        ),
                      ),
                      const Text(
                        'Favourite',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            leading: QueryArtworkWidget(
              // controller: _audioQuery,
              id: searchdata.value[index].id!,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: const Icon(
                Icons.music_note,
                color: Colors.amber,
                size: 50,
              ),
            ),
            title: Text(
              searchdata.value[index].title!,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              ' ${searchdata.value[index].artist}',
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 4);
      },
      itemCount: searchdata.value.length,
    );
  }

  Widget searchFun(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, index) {
        return InkWell(
          onTap: () {
            onSongClickedFun(index);
          },
          child: ListTile(
            textColor: Colors.white,
            leading: QueryArtworkWidget(
              // controller: _audioQuery,
              id: globalController
                  .allsongs[index].id!, // Parse the ID as an integer
              type: ArtworkType.AUDIO,
              nullArtworkWidget: const Icon(
                Icons.music_note,
                color: Colors.amber,
                size: 50,
              ),
            ),
            trailing: PopupMenuButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) {
                if (value == 0) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => MyList(idx: index),
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
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FavIcon(
                        currentSong: globalController.allsongs[index],
                        isFav: favaroList.value.contains(
                          globalController.allsongs[index],
                        ),
                      ),
                      const Text(
                        'Favourite',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            title: Text(
              globalController.allsongs[index].title ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              globalController.allsongs[index].artist ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 4);
      },
      itemCount: globalController.allsongs.length,
    );
  }

  searchEmpty() {
    return const Center(
      child: Text(
        'Sorry, no results found. 🤷',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  searchT(String searchtext) {
    searchdata.value = globalController.allsongs
        .where((allsongs) => allsongs.title!
            .toLowerCase()
            .contains(searchtext.toLowerCase().trim()))
        .toList();
  }
}
