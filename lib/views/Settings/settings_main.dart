

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nazzbuzz/controller/settings_controller/settings_controller.dart';
import 'package:nazzbuzz/utils/color.dart';
import 'package:nazzbuzz/views/Settings/about_screen.dart/about_screen.dart';
import 'package:nazzbuzz/views/Settings/feedback_screen.dart/feedback.dart';
import 'package:nazzbuzz/views/Settings/privacy_screen.dart/privacy.dart';
import 'package:nazzbuzz/views/Settings/reset/reset1.dart';
import 'package:nazzbuzz/views/Settings/terms_screen.dart/terms.dart';

class SettingsMainScreen extends StatelessWidget {
  const SettingsMainScreen({super.key});

  @override
  Widget build(BuildContext context) {

    SettingsController settingsController = Get.put(SettingsController());

    // _onShare(context) async {
    //   final box = context.findRenderObject() as RenderBox?;
    //   await Share.share(
    //       'https://play.google.com/store/apps/details?id=com.example.nazzbuzz',
    //       subject: '',
    //       sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    // }

    return Scaffold(
      backgroundColor: kBlack,
      appBar: AppBar(
        backgroundColor: kBlack,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios, color: kWhite)),
        title: const Text(
          'Settings',
          style: TextStyle(color: kWhite),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          GestureDetector(
            child: const ListTile(
              leading:
                  Icon(Icons.privacy_tip_outlined, color: kWhite, size: 30),
              title: Text(
                'Privacy And Policy',
                style: TextStyle(color: kWhite, fontSize: 20),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: kWhite,
              ),
            ),
            onTap: () {
              Get.to(const PrivacyScreen());
            },
          ),
          GestureDetector(
            child: const ListTile(
              leading: Icon(
                Icons.insert_drive_file,
                color: kWhite,
                size: 30,
              ),
              title: Text(
                'Terms And Conditions',
                style: TextStyle(color: kWhite, fontSize: 20),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: kWhite,
              ),
            ),
            onTap: () {
              Get.to(const TermsScreen());
            },
          ),
          GestureDetector(
            child: const ListTile(
              leading: Icon(
                Icons.restart_alt_rounded,
                size: 30,
                color: kWhite,
              ),
              title: Text(
                'Reset',
                style: TextStyle(color: kWhite, fontSize: 20),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: kWhite,
              ),
            ),
            onTap: () {
              resetTheApp(context);
            },
          ),
          GestureDetector(
            child: const ListTile(
              leading: Icon(
                Icons.feedback,
                color: kWhite,
                size: 30,
              ),
              title: Text(
                'Feedback',
                style: TextStyle(color: kWhite, fontSize: 20),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: kWhite,
              ),
            ),
            onTap: () {
              Get.to(const FeedbackScreen());
            },
          ),
          GestureDetector(
            child: const ListTile(
              leading: Icon(
                Icons.info_outline,
                color: kWhite,
                size: 30,
              ),
              title: Text(
                'About Us',
                style: TextStyle(color: kWhite, fontSize: 20),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: kWhite,
              ),
            ),
            onTap: () {
              Get.to(const AboutScreen());
            },
          ),
          InkWell(
            child: ListTile(
              leading: const Icon(
                Icons.share_outlined,
                color: kWhite,
                size: 30,
              ),
              title: const Text(
                'Share Nazz-buzz~~',
                style: TextStyle(color: kWhite, fontSize: 20),
              ),
              onTap: () {
                settingsController.onShare(context);

              },
            ),
          ),
          const SizedBox(
            height: 260,
          ),
          Text(
            'Version 2.0',
            style: TextStyle(color: Colors.grey[500]),
          )
        ],
      ),
    );
  }

  void resetTheApp(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Reset Application?'),
            content:
                const Text('Are you sure you want to reset the application?'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('No'),
              ),
              TextButton(
                  onPressed: () {
                    Get.to(const FirstScreen());
                  },
                  child: const Text('Yes'))
            ],
          );
        });
  }
}
