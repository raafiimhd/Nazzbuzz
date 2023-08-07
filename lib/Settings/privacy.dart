import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: const Text(
          'Privacy And Policy',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Privacy Policy for Nazz-buzz~~',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              'Thank you for choosing to use the Nazz-buzz application (the "App"). We are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy explains how we collect, use, and safeguard your information when you use our App. By accessing and using the App, you agree to the terms of this Privacy Policy'
              '\nInformation We Collect'
              '\nWe may collect certain personal information from you when you create an account or use the App. This information may include your name, email address, username, and profile picture. Additionally, if you choose to connect your social media accounts, we may collect additional information from those accounts, such as your social media profile information and friend list (subject to your permissions).'
              '\n We also collect information about how you use the App. '
              '\nThis includes data regarding the songs you listen to, playlists you create, your browsing history within the App, and your interactions with other users. Furthermore, we automatically collect certain information about your device, such as device type, operating system, unique device identifiers, and mobile network information. With your consent, we may collect and process information about your precise or approximate location when you use the App for location-based features.'
              '\nHow We Use Your Information'
              '\n We use the information we collect for various purposes, including:'
              '\nProviding and personalizing the App: We utilize your personal information to offer you a seamless and personalized user experience within the App. This involves creating personalized recommendations, playlists, and suggestions based on your music preferences and usage patterns.'
              '\nCommunication: We may use your contact information to send you important updates, notifications, and promotional messages related to the App. You have the option to opt-out of promotional communications by following the instructions provided in the communication or adjusting your preferences in the App settings.'
              '\nAggregated Data: We may aggregate and anonymize data for analytical and statistical purposes to improve the Apps functionality, develop new features, and gain insights into user trends and preferences. Please note that aggregated data does not personally identify you.'
              '\nLegal Compliance and Protection: We may use your information to comply with applicable laws, regulations, legal processes, and enforce our rights. Additionally, we may utilize your data to protect the safety and security of our users.),',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      )),
    );
  }
}
