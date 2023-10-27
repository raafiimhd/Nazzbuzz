import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:get/get.dart';
import 'package:nazzbuzz/utils/color.dart';
import 'package:nazzbuzz/views/home/home_screen.dart';
import 'package:nazzbuzz/views/allsongs/all_songs_screen.dart';
import 'package:nazzbuzz/controller/home_controller/home_screen_controller.dart';
import 'package:nazzbuzz/views/favourite_screen/favourite_screen.dart';

class MainpageScreen extends StatelessWidget {
  const MainpageScreen({Key? key, required this.tabController}) : super(key: key);
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    HomeGetxController addController = Get.put(HomeGetxController());
    var size, height, width;
      size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    double horizontalSpacing = width < 600 ? 130.0 : 150.0;
    return Column(
      children: [
        Container(
          color:kBlack,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        addController.toggleShuffle();
                      },
                      icon: Icon(
                        addController.isShuffleEnabled
                            ? Icons.shuffle_on_sharp
                            : Entypo.shuffle,
                        color: kWhite,
                      )),
                  const Text(
                    'Shuffle All',
                    style: TextStyle(
                      color: kWhite,
                      fontSize: 16,
                    ),
                  ),
                   SizedBox(
                    width: horizontalSpacing
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(const FavouriteScreen());
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: kWhite,
                    ),
                  ),
                  PopupMenuButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: kWhite,
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: const Text(
                          'Playlist',
                          style: TextStyle(
                            color: kBlack,
                          ),
                        ),
                        onTap: () => tabController.animateTo(1),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
            child: AllSongsScreen(
                onFavouritePressed: TextButton(
                    onPressed: () {
                      Get.to(const FavouriteScreen());
                    },
                    child: const Text('Favourite')),
                onPlaylistPressed: TextButton(
                    onPressed: () {
                      Get.to(const HomeScreen(
                        initialTabIndex: 1,
                      ));
                    },
                    child: const Text('Playlist'))))
      ],
    );
  }
}
