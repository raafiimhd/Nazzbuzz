import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nazzbuzz/controller/splash_screen_controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      init: SplashScreenController(),
      builder: (controller) {
        if (controller.hasPermission) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/splash_Nazz-buzz-removebg-preview.png'),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Nazz-buzz~~',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        color: Colors.purple,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          // Handle the case when permission is not granted
          // You can show an error message or take appropriate action.
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Text('Permission not granted'),
            ),
          );
        }
      },
    );
  }
}
