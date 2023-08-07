import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:nazzbuzz/Screens/home.dart';
import 'package:nazzbuzz/Screens/whole2.dart';
import 'package:nazzbuzz/library/favourite/favourite.dart';

class MainpageScreen extends StatefulWidget {
  const MainpageScreen({Key? key, required this.tabController})
      : super(key: key);
  final TabController tabController;

  @override
  State<MainpageScreen> createState() => _MainpageScreenState();
}

class _MainpageScreenState extends State<MainpageScreen> {
  bool isShuffleEnabled = false;
  void toggleShuffle() {
    setState(() {
      isShuffleEnabled = !isShuffleEnabled;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: IconButton(
                        onPressed: () {
                          toggleShuffle();
                        },
                        icon: Icon(
                          isShuffleEnabled
                              ? Icons.shuffle_on_sharp
                              : Entypo.shuffle,
                          color: Colors.white,
                        )),
                  ),
                  const Text(
                    'Shuffle All',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 110,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => FavouriteScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: PopupMenuButton(
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: const Text(
                            'Playlist',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          onTap: () => widget.tabController.animateTo(1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Mainpage1Content(
            onFavouritePressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => FavouriteScreen(),
                ),
              );
            },
            onPlaylistPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const HomeScreen(
                    initialTabIndex: 1,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
