import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nazzbuzz/controller/settings_controller/settings_controller.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = Get.put(SettingsController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: const Text(
            'Feedback',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ))),
      body: Form(
          key: settingsController.formkey,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller:settingsController. nameEditingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter your name';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      hintText: 'Name',
                      hintStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: TextFormField(
                  maxLines: 3,
                  controller: settingsController.feedbackEditingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Fill your feedback';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      hintText: 'Feedback',
                      hintStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300)),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                 settingsController. submit(context);
                },
                icon: const Icon(Icons.send_rounded),
                label: const Text('Send Feedback'),
              )
            ],
          )),
    );
  }

 
}
