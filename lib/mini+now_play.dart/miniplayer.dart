import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:nazzbuzz/core/global.dart';
import 'package:nazzbuzz/mini+now_play.dart/nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => NowPlayingScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: player.builderCurrent(builder: (context, playing) {
          int id = int.parse(playing.audio.audio.metas.id!);
          return Container(
            width: 350,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: GestureDetector(
              child: Row(
                children: [
                  const SizedBox(width: 7),
                  QueryArtworkWidget(
                    id: id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: const CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          AssetImage('assets/images/images (3).jpg'),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Marquee(
                            text: playing.audio.audio.metas.title!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            blankSpace: 150,
                          ),
                        ),
                        Text(
                          playing.audio.audio.metas.artist!,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      player.previous();
                    },
                    icon: const Icon(
                      Icons.skip_previous,
                      color: Color.fromARGB(255, 11, 11, 11),
                    ),
                    iconSize: 25,
                  ),
                  InkWell(
                    onTap: () {
                      player.playOrPause();
                    },
                    child: PlayerBuilder.isPlaying(
                        player: player,
                        builder: (context, isplaying) {
                          if (isplaying) {
                            return const Icon(
                              Icons.pause,
                              color: Colors.black,
                            );
                          } else {
                            return const Icon(
                              Icons.play_arrow,
                              color: Colors.black,
                            );
                          }
                        }),
                  ),
                  // ValueListenableBuilder(
                  //     valueListenable: isplaying,
                  //     builder: (context, value, child) {
                  //       return IconButton(
                  //         onPressed: () {
                  //           isplaying.value = !isplaying.value;
                  //           player.playOrPause();
                  //         },
                  //         icon: isplaying.value
                  //             ? const Icon(
                  //                 Icons.pause,
                  //                 color: Colors.black,
                  //               )
                  //             : const Icon(
                  //                 Icons.play_arrow,
                  //                 color: Colors.black,
                  //               ),
                  //       );
                  //     }),
                  IconButton(
                    onPressed: () {
                      player.next();
                    },
                    icon: const Icon(
                      Icons.skip_next,
                      color: Color.fromARGB(255, 9, 9, 9),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
