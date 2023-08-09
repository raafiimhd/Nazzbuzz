import 'package:flutter/material.dart';
import 'package:nazzbuzz/Settings/privacy.dart';
import 'package:nazzbuzz/Settings/about.dart';
import 'package:nazzbuzz/Settings/feedback.dart';
import 'package:nazzbuzz/Settings/reset/reset1.dart';
import 'package:nazzbuzz/Settings/terms.dart';
// import 'package:share_plus/share_plus.dart';

class SettingsMainScreen extends StatefulWidget {
  const SettingsMainScreen({super.key});

  @override
  State<SettingsMainScreen> createState() => _SettingsMainScreenState();
}

class _SettingsMainScreenState extends State<SettingsMainScreen> {
  @override
  Widget build(BuildContext context) {
    // _onShare(context) async {
    //   final box = context.findRenderObject() as RenderBox?;
    //   await Share.share(
    //       'https://play.google.com/store/apps/details?id=com.example.nazzbuzz',
    //       subject: '',
    //       sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    // }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          GestureDetector(
            child: const ListTile(
              leading: Icon(Icons.privacy_tip_outlined,
                  color: Colors.white, size: 30),
              title: Text(
                'Privacy And Policy',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const PrivacyScreen()));
            },
          ),
          GestureDetector(
            child: const ListTile(
              leading: Icon(
                Icons.insert_drive_file,
                color: Colors.white,
                size: 30,
              ),
              title: Text(
                'Terms And Conditions',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const TermsScreen()));
            },
          ),
          GestureDetector(
            child: const ListTile(
              leading: Icon(
                Icons.restart_alt_rounded,
                size: 30,
                color: Colors.white,
              ),
              title: Text(
                'Reset',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
            onTap: () {
              resetTheApp();
            },
          ),
          GestureDetector(
            child: const ListTile(
              leading: Icon(
                Icons.feedback,
                color: Colors.white,
                size: 30,
              ),
              title: Text(
                'Feedback',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const FeedbackScreen()));
            },
          ),
          GestureDetector(
            child: const ListTile(
              leading: Icon(
                Icons.info_outline,
                color: Colors.white,
                size: 30,
              ),
              title: Text(
                'About Us',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const AboutScreen()));
            },
          ),
          InkWell(
            child: ListTile(
              leading: const Icon(
                Icons.share_outlined,
                color: Colors.white,
                size: 30,
              ),
              title: const Text(
                'Share Nazz-buzz~~',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onTap: () {
                // _onShare(context);
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

  void resetTheApp() {
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
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const FirstScreen()));
                  },
                  child: const Text('Yes'))
            ],
          );
        });
  }
}
