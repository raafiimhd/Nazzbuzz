import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'About Us',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'About Us'
            ' Nazz-buzz is a music player application designed to provide an enjoyable and personalized music experience to our users. Our mission is to connect music lovers with their favorite tunes and create a platform that enhances their music discovery and listening journey.'
            'We are passionate about music and technology, and we strive to create an intuitive and feature-rich app that caters to the diverse needs and preferences of our users. Our team consists of talented individuals with expertise in music streaming, app development, and user experience design.'
            'At Nazz-buzz, we are committed to maintaining the privacy and security of our users information. We adhere to strict data protection practices and comply with applicable privacy laws to ensure that your personal information is handled with the utmost care and confidentiality. We value transparency and have implemented this Privacy Policy to explain how we collect, use, and protect your data.'
            'We continuously work to improve the Apps functionality, performance, and user experience. We appreciate user feedback and take it into consideration as we make updates and enhancements to the App. Our goal is to create a seamless and enjoyable music listening experience that keeps you connected to your favorite songs and artists.'
            'If you have any questions, concerns, or feedback regarding the App or our services, please dont hesitate to contact us. We are dedicated to providing excellent customer support and addressing any inquiries or issues in a timely manner.'
            'Thank you for choosing Nazz-buzz. We hope you enjoy the App and have a fantastic music-filled experience!',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
