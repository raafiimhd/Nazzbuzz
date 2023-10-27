import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class SettingsController extends GetxController{
    final formkey = GlobalKey<FormState>();
  final nameEditingController = TextEditingController();
  final feedbackEditingController = TextEditingController();
   void submit(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
        content: Text(
          'Successful',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
    await Future.delayed(
      const Duration(seconds: 2),
    );
  }
  bool showSkipButton = false;
  bool isPressed = false;

  final List<String> imagelist = [
    'assets/images/reset1.jpg',
    'assets/images/reset2.jpg',
    'assets/images/reset3.jpg',
  ];
  int mainindex = 0;

   onShare(context) async {
      final box = context.findRenderObject() as RenderBox?;
      await Share.share(
          'https://play.google.com/store/apps/details?id=com.example.nazzbuzz',
          subject: '',
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
}