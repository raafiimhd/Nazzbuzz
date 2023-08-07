import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nazzbuzz/Screens/splash.dart';
import 'package:nazzbuzz/database/functions/mostly_playeddb.dart';
import 'package:nazzbuzz/database/functions/recently_db.dart';
import 'package:nazzbuzz/database/model/db_model.dart';
import 'package:nazzbuzz/database/model/fav_model.dart';
import 'package:nazzbuzz/database/model/mostly_played.dart';
import 'package:nazzbuzz/database/model/playlist_model/playlist_model.dart';
import 'package:nazzbuzz/database/model/recent_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(SongInfoAdapter().typeId)) {
    Hive.registerAdapter(SongInfoAdapter());
  }
  if (!Hive.isAdapterRegistered(AppPlaylistAdapter().typeId)) {
    Hive.registerAdapter(AppPlaylistAdapter());
  }
  if (!Hive.isAdapterRegistered(FavmodelAdapter().typeId)) {
    Hive.registerAdapter(FavmodelAdapter());
  }
  if (!Hive.isAdapterRegistered(MostlyPlayedAdapter().typeId)) {
    Hive.registerAdapter(MostlyPlayedAdapter());
  }
  if (!Hive.isAdapterRegistered(RecentlyPlayedAdapter().typeId)) {
    Hive.registerAdapter(RecentlyPlayedAdapter());
  }
  await Hive.openBox<SongInfo>('all Songs');
  await Hive.openBox<Favmodel>('Favaourites');
  await openMostly();
  await openRecentlyPlayedDB();
//  await openBoxAndWriteData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
