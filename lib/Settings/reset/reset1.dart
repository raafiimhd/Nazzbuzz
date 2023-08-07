import 'package:flutter/material.dart';
import 'package:nazzbuzz/Screens/splash.dart';
import 'package:nazzbuzz/Settings/reset/pageview_widget.dart';
import 'package:nazzbuzz/database/functions/fav_db.dart';
import 'package:nazzbuzz/database/functions/mostly_playeddb.dart';
import 'package:nazzbuzz/database/functions/playlist_db.dart';
import 'package:nazzbuzz/database/functions/recently_db.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool showSkipButton = false;
  bool isPressed = false;

  final List<String> imagelist = [
    'assets/images/reset1.jpg',
    'assets/images/reset2.jpg',
    'assets/images/reset3.jpg',
  ];
  int mainindex = 0;
  @override
  @override
  Widget build(BuildContext context) {
    double kwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        PageView.builder(
            controller: PageController(initialPage: mainindex),
            itemCount: 3,
            onPageChanged: (value) {
              mainindex = value;
              Future.delayed(const Duration(milliseconds: 200));
              setState(() {});
            },
            itemBuilder: (context, index) {
              return Stack(children: [
                Padding(
                  padding: EdgeInsets.only(left: kwidth * 0.10),
                  child: Pageviewwidget(
                      image: imagelist[index], text: 'Music is Life'),
                ),
                Positioned(
                    bottom: 20,
                    child: Padding(
                      padding: EdgeInsets.only(left: kwidth * 0.32),
                      child: ElevatedButton(
                          onPressed: () {
                            clearFav();
                            clearRecently();
                            clearMostly();
                            playlistClear();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => const SplashScreen()));
                          },
                          child: const Text('Get Started')),
                    ))
              ]);
            }),
        Positioned(
          bottom: 100,
          child: SizedBox(
            height: 30,
            child: ListView.builder(
              padding: EdgeInsets.only(left: kwidth * 0.15),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: imagelist.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {},
                child: Padding(
                    padding: EdgeInsets.only(left: kwidth * 0.13),
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor:
                          mainindex == index ? Colors.blue : Colors.white,
                    )),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
