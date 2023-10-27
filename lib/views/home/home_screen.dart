import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nazzbuzz/utils/color.dart';
import 'package:nazzbuzz/utils/const.dart';
import 'package:nazzbuzz/views/home/widgets/home_widgets.dart';
import 'package:nazzbuzz/views/Settings/settings_main.dart';
import 'package:nazzbuzz/controller/home_controller/home_screen_controller.dart';
import 'package:nazzbuzz/views/search_screen/search_screen.dart';
import 'package:nazzbuzz/views/library/liberary.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.initialTabIndex}) : super(key: key);

  final int initialTabIndex;

  @override
  Widget build(BuildContext context) {
    double kwidth = MediaQuery.of(context).size.width;
    HomeGetxController homeController = Get.put(HomeGetxController());
    return Scaffold(
        backgroundColor: kBlack,
        // Your existing scaffold code here
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.to(const SettingsMainScreen());
              },
              icon: const Icon(
                Icons.settings,
                color: kWhite
              )),
          centerTitle: true,
          title: const Text(
            'Nazz-buzz~~',
            style: TextStyle(
              color: kWhite,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(left: kwidth * 0.1),
                child: IconButton(
                  onPressed: () {
                    Get.to(const SearchScreen());
                  },
                  icon: const Icon(Icons.search),
                  color: kWhite
                )),
          ],
          backgroundColor: kBlack,
          bottom: TabBar(
            tabs: homeController.myTab,
            controller: globalController.tabController,
            indicatorColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.tab,
            onTap: homeController.handleTabSelection,
          ),
        ),
        body: TabBarView(
          controller: globalController.tabController,
          children: [
            MainpageScreen(tabController: globalController.tabController),
            const LiberaryScreen(),
          ],
        ));
  }
}
