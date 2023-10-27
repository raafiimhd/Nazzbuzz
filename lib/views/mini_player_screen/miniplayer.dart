import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:nazzbuzz/utils/color.dart';
import 'package:nazzbuzz/utils/const.dart';
import 'package:nazzbuzz/views/now_playing_screen/nowplaying.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to( const NowPlayingScreen());
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            globalController.player.builderCurrent(builder: (context, playing) {
          int id = int.parse(playing.audio.audio.metas.id!);
          return Container(
            width: 350,
            height: 80,
            decoration: BoxDecoration(
              color: kWhite,
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
                              color: kBlack,
                            ),
                            blankSpace: 150,
                          ),
                        ),
                        Text(
                          playing.audio.audio.metas.artist!,
                          style: const TextStyle(
                            color: kBlack
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      globalController.player.previous();
                    },
                    icon: const Icon(
                      Icons.skip_previous,
                      color: kBlack
                    ),
                    iconSize: 25,
                  ),
                  InkWell(
                    onTap: () {
                      globalController.player.playOrPause();
                    },
                    child: PlayerBuilder.isPlaying(
                        player: globalController.player,
                        builder: (context, isplaying) {
                          if (isplaying) {
                            return const Icon(
                              Icons.pause,
                              color: kBlack
                            );
                          } else {
                            return const Icon(
                              Icons.play_arrow,
                              color: kBlack
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
                      globalController.player.next();
                    },
                    icon: const Icon(
                      Icons.skip_next,
                      color: kBlack
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
