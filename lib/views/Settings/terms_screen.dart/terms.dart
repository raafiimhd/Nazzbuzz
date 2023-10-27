import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

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
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: const Text(
          'Terms And Conditions',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Text(
                '  Terms and conditions',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Last Updated:01/07/2023',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'These Terms of Use ("Terms") govern your use of the Nazz-buzz application (the "App").'
                ' Please read these Terms carefully before using the App. By accessing or using the App, you agree to be bound by these Terms.'
                'License and App Usage'
                '1.1 License: Subject to your compliance with these Terms, we grant you a limited, non-exclusive, non-transferable, and revocable license to use the App for personal, non-commercial purposes.'
                '1.2 App Restrictions: You agree not to:'
                'a) Use the App for any unlawful or unauthorized purpose.'
                'b) Modify, adapt, or create derivative works of the App.'
                'c) Copy, reproduce, distribute, transmit, display, or publicly perform the App or any content within the App, except as expressly permitted.'
                'd) Use any automated means, including bots, crawlers, or scrapers, to access or interact with the App, except for standard search engine indexing.'
                'e) Interfere with or disrupt the operation of the App or its servers.'
                'f) Attempt to gain unauthorized access to the App, user accounts, or any other systems or networks connected to the App.'
                'User Content'
                '2.1 User Responsibility: You are solely responsible for any content you upload, share, or submit through the App ("User Content"). You retain ownership of your User Content, but by posting or submitting it, you grant us a non-exclusive, worldwide, royalty-free license to use, display, reproduce, modify, and distribute your User Content for the purposes of operating and improving the App.'
                '2.2 Content Guidelines: You agree not to submit User Content that is unlawful, offensive, defamatory, infringing, or violates the rights of any third party. We reserve the right to remove or disable any User Content that violates these Terms or is deemed inappropriate in our sole discretion.'
                'Intellectual Property'
                '3.1 App Ownership: The App, including its design, features, logos, and content, is owned by us or our licensors and is protected by intellectual property laws. You acknowledge that you have no ownership or rights to the App, except for the limited license granted under these Terms.'
                '3.2 Trademarks: The Nazz-buzz name, logo, and any other trademarks associated with the App are our trademarks and may not be used without our prior written permission.'
                'Third-Party Services and Links'
                '4.1 Third-Party Services: The App may integrate or provide links to third-party services, websites, or resources. We are not responsible for the availability, accuracy, or content of these third-party services. Your use of such services is subject to their respective terms and policies.'
                '4.2 User Interactions: Any interactions or transactions between you and third parties found through the App are solely between you and those third parties. We are not responsible for any damages or liabilities arising from such interactions or transactions.'
                'Disclaimer of Warranties'
                'The App is provided on an as is and as available basis. We make no warranties or representations express or implied regarding the Apps reliability accuracy availability or suitability for any purpose. Your use of the App is at your own risk'
                'Limitation of Liability'
                'To the maximum extent permitted by applicable law we shall not be liable for any indirect incidental consequential or punitive damages arising out of or in connection with your use of the App regardless of the cause of action.'
                'Indemnification'
                'You agree to indemnify defend and hold us harmless from any claims damages losses liabilities and expenses including legal fees arising out of',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
