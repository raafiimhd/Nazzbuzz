import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:get/get.dart';
import 'package:nazzbuzz/utils/color.dart';
import 'package:nazzbuzz/utils/const.dart';
import 'package:nazzbuzz/views/mini_player_screen/miniplayer.dart';
import 'package:nazzbuzz/views/favourite_screen/favourite_screen.dart';
import 'package:nazzbuzz/views/mostly_played_screen/mostly_played_screen.dart';
import 'package:nazzbuzz/views/recently_played_screen/recently_played_screen.dart';
import 'package:nazzbuzz/views/playlist/playlist.dart';

class LiberaryScreen extends StatelessWidget {
  const LiberaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      body: Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(14),
                child: Text(
                  'LIBRARY',
                  style: TextStyle(
                    color: kWhite,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                width: 210,
              ),
            ],
          ),
          GestureDetector(
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 226, 219, 219),
                    border: Border.all(),
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: kWhite,
                  ),
                ),
              ),
              title: const Text(
                'FAVOURITE',
                style: TextStyle(color: kWhite, fontSize: 20),
              ),
              subtitle: const Text(
                'Songs',
                style: TextStyle(
                  color: kWhite,
                ),
              ),
              onTap: () {
                Get.to(const FavouriteScreen());
              },
            ),
          ),
          GestureDetector(
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 226, 219, 219),
                    border: Border.all(),
                  ),
                  child: const Icon(
                    Entypo.list_add,
                    color: kWhite,
                  ),
                ),
              ),
              title: const Text(
                'PLAYLIST',
                style: TextStyle(color: kWhite, fontSize: 20),
              ),
              subtitle: const Text(
                'Songs',
                style: TextStyle(
                  color: kWhite,
                ),
              ),
              onTap: () {
                Get.to(MyList(
                  idx: null,
                ));
              },
            ),
          ),
          GestureDetector(
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 226, 219, 219),
                    border: Border.all(),
                  ),
                  child: const Icon(
                    Icons.queue_music,
                    color: kWhite,
                  ),
                ),
              ),
              title: const Text(
                'RECENTLY PLAYED',
                style: TextStyle(color: kWhite, fontSize: 20),
              ),
              subtitle: const Text(
                'Songs',
                style: TextStyle(
                  color: kWhite,
                ),
              ),
            ),
            onTap: () {
              Get.to( const Recently());
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 226, 219, 219),
                    border: Border.all(),
                  ),
                  child: const Icon(
                    Icons.queue_music,
                    color: kWhite,
                  ),
                ),
              ),
              title: const Text(
                'MOSTLY PLAYED',
                style: TextStyle(color: kWhite, fontSize: 20),
              ),
              subtitle: const Text(
                'Songs',
                style: TextStyle(
                  color: kWhite,
                ),
              ),
            ),
            onTap: () => Get.to(const MostlyPlayedScreen()),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: globalController.isMiniPlayerVisible
                ? const MiniPlayer()
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}
