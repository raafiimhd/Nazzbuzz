import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nazzbuzz/core/global.dart';
import 'package:nazzbuzz/database/functions/fav_db.dart';
import 'package:nazzbuzz/database/model/db_model.dart';
import 'package:nazzbuzz/library/favourite/fav_icon.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlayingScreen extends StatefulWidget {
  NowPlayingScreen({
    super.key,
  });

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  bool isShuffleEnabled = false;
  bool isRepeatenabled = false;
  late SongInfo currentsong;

  double volume = 0.3;
  void setVolume(double value) {
    setState(() {
      volume = value;
    });
    player.setVolume(value);
  }

  void toggleShuffle() {
    setState(() {
      isShuffleEnabled = !isShuffleEnabled;
    });
  }

  void enableRepeat() {
    player.setLoopMode(LoopMode.single);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Now Playing',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: SafeArea(
        child: Column(
          children: [
            player.builderCurrent(
              builder: (context, playing) {
                int id = int.parse(playing.audio.audio.metas.id!);
                currentsong = currentsongfinder(id)!;
                return Container(
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
                            color: Colors.white,
                          ),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight:
                                  1.0, // Adjust the height of the slider track
                              thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius:
                                      7.0), // Adjust the size of the thumb
                              activeTrackColor: const Color.fromARGB(
                                  255,
                                  245,
                                  245,
                                  245), // Set the color of the active track
                              inactiveTrackColor: const Color.fromARGB(
                                  255,
                                  206,
                                  206,
                                  206), // Set the color of the inactive track
                              thumbColor:
                                  Colors.white, // Set the color of the thumb
                            ),
                            child: Slider(
                              value: volume,
                              min: 0.0,
                              max: 1.0,
                              onChanged: setVolume,
                            ),
                          ),
                          Text(
                            '${(volume * 100).toStringAsFixed(0)}%',
                            style: const TextStyle(color: Colors.white),
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
                                player.getCurrentAudioTitle,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .01,
                              ),
                              Text(
                                player.getCurrentAudioArtist,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white),
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
                            player: player,
                            builder: (context, duration) {
                              final totalDuration =
                                  player.current.value?.audio.duration;
                              return ProgressBar(
                                progress: duration,
                                total: totalDuration!,
                                progressBarColor: Colors.grey,
                                baseBarColor: Colors.white,
                                bufferedBarColor: Colors.white,
                                thumbColor: Colors.white,
                                barHeight: 3.0,
                                thumbRadius: 7.0,
                                onSeek: (duration) {
                                  player.seek(duration);
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
                                onPressed: toggleShuffle,
                                icon: Icon(
                                  isShuffleEnabled
                                      ? Icons.shuffle_on_sharp
                                      : Icons.shuffle,
                                  color: Colors.white,
                                ),
                              ),
                              favIcon(
                                currentSong: currentsong,
                                isfav: favaroList.value.contains(currentsong),
                              ),
                              IconButton(
                                tooltip: 'Repeat',
                                onPressed: () {
                                  enableRepeat();
                                  setState(() {
                                    isRepeatenabled = !isRepeatenabled;
                                  });
                                },
                                icon: Icon(
                                  isRepeatenabled
                                      ? Icons.repeat_one_sharp
                                      : Icons.repeat,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                tooltip: 'playlist',
                                onPressed: () {
                                  // player.to;
                                  // setState(() {
                                  //   isShuffleEnabled = !isShuffleEnabled;
                                  //   });
                                },
                                icon: const Icon(
                                  Icons.playlist_add,
                                  color: Colors.white,
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
                                player.previous();
                              },
                              icon: const Icon(
                                FontAwesomeIcons.backward,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                skipBackward(const Duration(seconds: 10));
                              },
                              icon: const Icon(Icons.replay_10,
                                  size: 30, color: Colors.white),
                            ),
                            InkWell(
                              onTap: () {
                                player.playOrPause();
                              },
                              child: SizedBox(
                                child: PlayerBuilder.isPlaying(
                                  player: player,
                                  builder: (context, isPlaying) {
                                    if (isPlaying) {
                                      return const Icon(
                                        Icons.pause,
                                        size: 38,
                                        color: Colors.white,
                                      );
                                    } else {
                                      return const Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 38,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                skipForward(const Duration(seconds: 10));
                              },
                              icon: const Icon(
                                Icons.forward_10,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                player.next();
                              },
                              icon: const Icon(FontAwesomeIcons.forward,
                                  color: Colors.white),
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

  void skipForward(Duration duration) {
    player.seekBy(duration);
  }

  void skipBackward(Duration duration) {
    player.seekBy(-duration);
  }

  SongInfo? currentsongfinder(int id) {
    for (SongInfo song in allsongs) {
      if (id == song.id) {
        return song;
      }
    }
    return null;
  }
}
