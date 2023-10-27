import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nazzbuzz/controller/playlist_controller/playlist_controller.dart';
import 'package:nazzbuzz/services/playlist_db/playlist_db.dart';
import 'package:nazzbuzz/utils/color.dart';
import 'package:nazzbuzz/utils/const.dart';
import 'package:nazzbuzz/views/playlist/playlistdetails.dart';



class MyList extends StatelessWidget {
  MyList({super.key, required this.idx});

  int? idx;

  @override
  Widget build(BuildContext context) {
    PlaylistController playlistController = Get.put(PlaylistController());
    getplayList();
    return Scaffold(
        backgroundColor: kBlack,
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            )),
                        const SizedBox(
                          width: 260,
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: IconButton(
                              onPressed: () {
                                playlistController
                                    .showAddPlaylistDialog(context);
                              },
                              icon: const Icon(
                                Icons.playlist_add,
                                color: kWhite,
                              )),
                        )
                      ],
                    ),
                    const SizedBox(height: 50),
                    const Padding(
                      padding: EdgeInsets.all(15),
                      // child: textWidget(
                      //     name: 'My List', fontWeight: FontWeight.bold, size: 40),
                      child: Text(
                        'My List',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: kWhite),
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: playListNotifier,
                      builder: (context, value, child) {
                        return playListNotifier.value.isNotEmpty
                            ? Expanded(
                                child: SizedBox(
                                    height: 500,
                                    child: GridView.count(
                                      crossAxisCount:
                                          2, // Number of columns in the grid
                                      crossAxisSpacing:
                                          10, // Spacing between columns
                                      mainAxisSpacing:
                                          10, // Spacing between rows
                                      padding: const EdgeInsets.all(
                                          10), // Padding around the grid
                                      children: List.generate(
                                          playListNotifier.value.length,
                                          (index) {
                                        return InkWell(
                                          onTap: () {
                                            if (idx != null) {
                                              playlistAddDB(
                                                  globalController
                                                      .allsongs[idx!],
                                                  playListNotifier
                                                      .value[index].name);
                                              playListNotifier
                                                  .value[index].container
                                                  .add(globalController
                                                      .allsongs[idx!]);
                                            }
                                            Get.to(
                                              value.isEmpty
                                                  ? const CircularProgressIndicator()
                                                  : ListingScreen(
                                                      playlistName:
                                                          playListNotifier
                                                              .value[index]
                                                              .name,
                                                      idx: index),
                                            );
                                          },
                                          child: card(
                                              index,
                                              playListNotifier
                                                  .value[index].name,
                                              context),
                                        );
                                      }),
                                    )),
                              )
                            : SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.300999,
                                child: const Center(
                                  child: Text(
                                    'Play List is empty',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: kWhite),
                                  ),
                                ),
                              );
                      },
                    ),
                  ])),
        ));
  }
}

Widget card(int index, var playlistName, BuildContext context) {
  return Card(
    elevation: 10,
    child: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: Offset(2, 2), color: Color.fromARGB(255, 215, 215, 215)),
        ],
        color: kWhite,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Edit Playlist'),
                          ),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Delete Playlist'),
                          ),
                        ],
                      ),
                    ),
                  ];
                },
                onSelected: (value) {
                  if (value == 'edit') {
                    editShowAddPlaylistDialog(
                      context,
                      index,
                      playListNotifier.value[index].name,
                    );
                  } else if (value == 'delete') {
                    playlistdelete(index);
                  }
                },
              )
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          const Icon(Icons.music_note),
          Text(playlistName)
        ],
      ),
    ),
  );
}

void editShowAddPlaylistDialog(BuildContext context, index, playlistName) {
  TextEditingController playlistController =
      TextEditingController(text: playlistName);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return GetBuilder<PlaylistController>(
        builder: (controller) {
          return AlertDialog(
            title: const Text('Update Playlist'),
            content: TextField(
                onChanged: (value) {
                  playlistName = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter playlist name',
                ),
                controller: playlistController),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  playlistrename(index, playlistName);
                  Get.back(); // Close the dialog
                },
                child: const Text('Edit'),
              ),
            ],
          );
        },
      );
    },
  );
}
