import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nazzbuzz/controller/nowplaying_controller/nowplaying_controller.dart';
import 'package:nazzbuzz/utils/color.dart';
import 'package:nazzbuzz/utils/const.dart';
import 'package:nazzbuzz/services/fav_db/fav_db.dart';
import 'package:nazzbuzz/views/favourite_screen/widgets/fav_icon.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    NowPlayingController nowPlayingController = Get.put(NowPlayingController());
    return Scaffold(
      backgroundColor: kBlack,
      appBar: AppBar(
        backgroundColor: kBlack,
        centerTitle: true,
        title: const Text(
          'Now Playing',
          style: TextStyle(color: kWhite),
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kWhite,
            )),
      ),
      body: SafeArea(
        child: Column(
          children: [
            globalController.player.builderCurrent(
              builder: (context, playing) {
                int id = int.parse(playing.audio.audio.metas.id!);
                nowPlayingController.currentsong =
                    nowPlayingController.currentsongfinder(id)!;
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .44,
                        decoration: const BoxDecoration(),
                        child: ClipOval(
                          child: QueryArtworkWidget(
                            id: id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: const CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  AssetImage('assets/images/images (3).jpg'),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.volume_down_sharp,
                            color: kWhite,
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight:
                                  1.0, // Adjust the height of the slider track
                              thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius:
                                      7.0), // Adjust the size of the thumb
                              activeTrackColor:
                                  kWhite, // Set the color of the active track
                              inactiveTrackColor:
                                  kWhite, // Set the color of the inactive track
                              thumbColor: kWhite, // Set the color of the thumb
                            ),
                            child: Slider(
                              value: nowPlayingController.volume,
                              min: 0.0,
                              max: 1.0,
                              onChanged: nowPlayingController.setVolume,
                            ),
                          ),
                          Text(
                            '${(nowPlayingController.volume * 100).toStringAsFixed(0)}%',
                            style: const TextStyle(color: kWhite),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      Center(
                        child: SizedBox(
                          width: 300,
                          child: Column(
                            children: [
                              Text(
                                globalController.player.getCurrentAudioTitle,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: kWhite,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .01,
                              ),
                              Text(
                                globalController.player.getCurrentAudioArtist,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: kWhite),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PlayerBuilder.currentPosition(
                            player: globalController.player,
                            builder: (context, duration) {
                              final totalDuration = globalController
                                  .player.current.value?.audio.duration;
                              return ProgressBar(
                                progress: duration,
                                total: totalDuration!,
                                progressBarColor: kWhite,
                                baseBarColor: kWhite,
                                bufferedBarColor: kWhite,
                                thumbColor: kWhite,
                                barHeight: 3.0,
                                thumbRadius: 7.0,
                                timeLabelTextStyle: const TextStyle(
                                  color: kWhite
                                ),
                                onSeek: (duration) {
                                  globalController.player.seek(duration);
                                },
                              );
                            }),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(21),
                          ),
                          // width: 150,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                tooltip: 'Shuffle',
                                onPressed: nowPlayingController.toggleShuffle,
                                icon: Icon(
                                  nowPlayingController.isShuffleEnabled
                                      ? Icons.shuffle_on_sharp
                                      : Icons.shuffle,
                                  color: kWhite,
                                ),
                              ),
                              FavIcon(
                                currentSong: nowPlayingController.currentsong,
                                isFav: favaroList.value
                                    .contains(nowPlayingController.currentsong),
                              ),
                              IconButton(
                                tooltip: 'Repeat',
                                onPressed: () {
                                  nowPlayingController.repeatFun();
                                },
                                icon: Icon(
                                  nowPlayingController.isRepeatenabled
                                      ? Icons.repeat_one_sharp
                                      : Icons.repeat,
                                  color: kWhite,
                                ),
                              ),
                              IconButton(
                                tooltip: 'playlist',
                                onPressed: () =>
                                    globalController.tabController.animateTo(1),
                                icon: const Icon(
                                  Icons.playlist_add,
                                  color: kWhite,
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                globalController.player.previous();
                              },
                              icon: const Icon(
                                FontAwesomeIcons.backward,
                                color: kWhite,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                nowPlayingController
                                    .skipBackward(const Duration(seconds: 10));
                              },
                              icon: const Icon(Icons.replay_10,
                                  size: 30, color: kWhite),
                            ),
                            InkWell(
                              onTap: () {
                                globalController.player.playOrPause();
                              },
                              child: SizedBox(
                                child: PlayerBuilder.isPlaying(
                                  player: globalController.player,
                                  builder: (context, isPlaying) {
                                    if (isPlaying) {
                                      return const Icon(
                                        Icons.pause,
                                        size: 38,
                                        color: kWhite,
                                      );
                                    } else {
                                      return const Icon(
                                        Icons.play_arrow,
                                        color: kWhite,
                                        size: 38,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                nowPlayingController
                                    .skipForward(const Duration(seconds: 10));
                              },
                              icon: const Icon(
                                Icons.forward_10,
                                size: 30,
                                color: kWhite,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                globalController.player.next();
                              },
                              icon: const Icon(FontAwesomeIcons.forward,
                                  color: kWhite),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              width: MediaQuery.of(context).size.height,
            ),
          ],
        ),
      ),
    );
  }
}
