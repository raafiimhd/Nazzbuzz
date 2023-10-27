import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nazzbuzz/model/allsongs_model/db_model.dart';
import 'package:nazzbuzz/model/fav_model/fav_model.dart';
import 'package:nazzbuzz/model/mostly_played_model/mostly_played.dart';
import 'package:nazzbuzz/model/playlist_model/playlist_model.dart';
import 'package:nazzbuzz/model/recently_played_model/recent_model.dart';
import 'package:nazzbuzz/utils/color.dart';
import 'package:nazzbuzz/views/splash_screen/splash_screen.dart';
import 'package:nazzbuzz/services/mostly_played_db/mostly_played_db.dart';
import 'package:nazzbuzz/services/recently_db/recently_db.dart';

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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kWhite,
        useMaterial3: true,
      ),
      home:  const SplashScreen(),
    );
  }
}
