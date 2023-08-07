import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nazzbuzz/Screens/home.dart';
import 'package:nazzbuzz/core/global.dart';
import 'package:nazzbuzz/database/model/db_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasPermission = false;
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void initState() {
    nextPage();
    
    super.initState();
  }

  Future checkAndRequestPermissions({bool retry = false}) async {
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );
    if (_hasPermission) {
      final allsongsDb = Hive.box<SongInfo>('all Songs');
      if (allsongsDb.values.isEmpty) {
        await fetchSongsfromstorage();
      } else {
        allsongs = allsongsDb.values.toList();
      }

      setState(() {});
    }
  }

  Future fetchSongsfromstorage() async {
    final allsongDb = Hive.box<SongInfo>('all Songs');
    List<SongModel> templist = await _audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    for (SongModel song in templist) {
      if (song.fileExtension == "mp3") {
        SongInfo songInfo = SongInfo(
            title: song.displayNameWOExt,
            artist: song.artist,
            id: song.id,
            duration: song.duration,
            uri: song.uri);
        allsongs.add(songInfo);
        allsongDb.add(songInfo);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splash_Nazz-buzz-removebg-preview.png'),
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Nazz-buzz~~',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 25,
                  color: Colors.purple,
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> nextPage() async {
    LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
    _audioQuery.setLogConfig(logConfig);
    await checkAndRequestPermissions();
    await Future.delayed(const Duration(seconds: 2));
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => HomeScreen(
                initialTabIndex: 0,
              )));
    });
  }
}
