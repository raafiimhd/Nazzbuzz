import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formkey = GlobalKey<FormState>();
  final _nameEditingController = TextEditingController();
  final _feedbackEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          key: _formkey,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  
                  controller: _nameEditingController,
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
                  controller: _feedbackEditingController,
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
                  submit();
                },
                icon: const Icon(Icons.send_rounded),
                label: const Text('Send Feedback'),
              )
            ],
          )),
    );
  }

  void submit() async {
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
}
