import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nazzbuzz/core/global.dart';
import 'package:nazzbuzz/database/functions/fav_db.dart';
import 'package:nazzbuzz/database/model/db_model.dart';
import 'package:nazzbuzz/mini+now_play.dart/miniplayer.dart';
import 'package:nazzbuzz/library/favourite/fav_icon.dart';
import 'package:nazzbuzz/playlist/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<SongInfo>> searchdata = ValueNotifier([]);

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

final TextEditingController _searchController = TextEditingController();

class _SearchScreenState extends State<SearchScreen> {
  bool isCloseButtonVisible = false;
  bool isMiniPlayerVisible = false;

  void onSongClicked(int index) {
    player.stop();
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
    player.open(Playlist(audios: audiolist, startIndex: index));

    setState(() {
      isMiniPlayerVisible = true;
    });
  }

  void onSongClickedFun(int index) {
    player.stop();
    List<Audio> audiolist = [];
    for (int i = 0; i < allsongs.length; i++) {
      audiolist.add(Audio.file(
        allsongs[i].uri!,
        metas: Metas(
          title: allsongs[i].title,
          artist: allsongs[i].artist,
          id: allsongs[i].id.toString(),
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: TextFormField(
            onChanged: (value) {
              searchT(value);
              setState(() {
                isCloseButtonVisible = value.isNotEmpty;
              });
            },
            controller: _searchController,
            decoration: InputDecoration(
                hintText: 'Search',
                filled: true,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                suffixIcon: Visibility(
                    visible: isCloseButtonVisible,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            isCloseButtonVisible = false;
                          });
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                        )))),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10,top: 7),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: searchdata,
                builder: (context, value, child) =>
                    _searchController.text.isEmpty ||
                            _searchController.text.trim().isEmpty
                        ? searchFun(context)
                        : searchdata.value.isEmpty
                            ? searchEmpty()
                            : searchFound(context),
              ),
            ),
            if (isMiniPlayerVisible) const MiniPlayer(),
          ],
        ),
      ),
    );
  }

  clearText(context) {
    if (_searchController.text.isNotEmpty) {
      _searchController.clear();
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
                    MaterialPageRoute(
                      builder: (ctx) => MyList(idx: index)
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
                      favIcon(
                        currentSong: searchdata.value[index],
                        isfav: favaroList.value.contains(
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
              id: allsongs[index].id!, // Parse the ID as an integer
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
                      favIcon(
                        currentSong: allsongs[index],
                        isfav: favaroList.value.contains(
                          allsongs[index],
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
              allsongs[index].title ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              allsongs[index].artist ?? 'Unknown',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 4);
      },
      itemCount: allsongs.length,
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
    searchdata.value = allsongs
        .where((allsongs) => allsongs.title!
            .toLowerCase()
            .contains(searchtext.toLowerCase().trim()))
        .toList();
  }
}
