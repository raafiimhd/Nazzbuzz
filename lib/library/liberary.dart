import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:nazzbuzz/mini+now_play.dart/miniplayer.dart';
import 'package:nazzbuzz/library/favourite/favourite.dart';
import 'package:nazzbuzz/library/mostly.dart';
import 'package:nazzbuzz/library/recently.dart';
import 'package:nazzbuzz/playlist/playlist.dart';

bool miniPlayerindex = false;

class LiberaryScreen extends StatefulWidget {
  const LiberaryScreen({Key? key}) : super(key: key);

  @override
  State<LiberaryScreen> createState() => _LiberaryScreenState();
}

class _LiberaryScreenState extends State<LiberaryScreen> {
  bool isMiniPlayerVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(14),
                child: Text(
                  'LIBRARY',
                  style: TextStyle(
                    color: Colors.white,
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
                    color: Colors.white,
                  ),
                ),
              ),
              title: const Text(
                'FAVOURITE',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              subtitle: const Text(
                'Songs',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => FavouriteScreen()),
                );
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
                    color: Colors.white,
                  ),
                ),
              ),
              title: const Text(
                'PLAYLIST',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              subtitle: const Text(
                'Songs',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => MyList(idx: null,)),
                );
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
                    color: Colors.white,
                  ),
                ),
              ),
              title: const Text(
                'RECENTLY PLAYED',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              subtitle: const Text(
                'Songs',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const Recently()),
              );
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
                    color: Colors.white,
                  ),
                ),
              ),
              title: const Text(
                'MOSTLY PLAYED',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              subtitle: const Text(
                'Songs',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const MostlyPlayedScreen()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: isMiniPlayerVisible ? const MiniPlayer() : const SizedBox(),
          )
        ],
      ),
    );
  }
}
