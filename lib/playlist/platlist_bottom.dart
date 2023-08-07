import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../core/global.dart';
import '../database/functions/playlist_db.dart';

class PlaylistBottomSheet extends StatelessWidget {
  PlaylistBottomSheet(
      {super.key, required this.playlistName, required this.idx});

  String playlistName;

  int idx;

  @override
  Widget build(BuildContext context) {
    getplayList();
    return Column(
      children: [
        const SizedBox(
          height: 50,
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'Add to play list',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Card(
                          color: Colors.grey[300],
                          child: InkWell(
                            onTap: () {
                              playlistAddDB(allsongs[index], playlistName);
                              playListNotifier.value[idx].container
                                  .add(allsongs[index]);
                              Navigator.pop(context);
                            },
                            child: ListTile(
                              leading: SizedBox(
                                width: 50,
                                height: 50,
                                child: ClipOval(
                                  child: QueryArtworkWidget(
                                    id: allsongs[index].id!,
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
                                allsongs[index].title!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              subtitle: Text(allsongs[index].artist!),
                            ),
                          ));
                    },
                    separatorBuilder: (context, index) =>
                        const Divider(height: 20),
                    itemCount: allsongs.length)),
          ),
        ),
      ],
    );
  }
}
