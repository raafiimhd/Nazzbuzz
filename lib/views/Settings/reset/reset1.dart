import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nazzbuzz/controller/settings_controller/settings_controller.dart';
import 'package:nazzbuzz/utils/color.dart';
import 'package:nazzbuzz/views/splash_screen/splash_screen.dart';
import 'package:nazzbuzz/views/Settings/reset/widgets/pageview_widget.dart';
import 'package:nazzbuzz/services/fav_db/fav_db.dart';
import 'package:nazzbuzz/services/mostly_played_db/mostly_played_db.dart';
import 'package:nazzbuzz/services/playlist_db/playlist_db.dart';
import 'package:nazzbuzz/services/recently_db/recently_db.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    double kwidth = MediaQuery.of(context).size.width;
    SettingsController settingsController = Get.put(SettingsController());
    return Scaffold(
      backgroundColor: kBlack,
      body: Stack(children: [
        PageView.builder(
            controller: PageController(initialPage:settingsController. mainindex),
            itemCount: 3,
            onPageChanged: (value) {
              settingsController.mainindex = value;
              Future.delayed(const Duration(milliseconds: 200));
            },
            itemBuilder: (context, index) {
              return Stack(children: [
                Padding(
                  padding: EdgeInsets.only(left: kwidth * 0.10),
                  child: Pageviewwidget(
                      image: settingsController.imagelist[index], text: 'Music is Life'),
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
              itemCount: settingsController.imagelist.length,
              itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(left: kwidth * 0.13),
                  child: CircleAvatar(
                    radius: 7,
                    backgroundColor:
                       settingsController. mainindex == index ? Colors.blue : kWhite,
                  )),
            ),
          ),
        ),
      ]),
    );
  }
}
