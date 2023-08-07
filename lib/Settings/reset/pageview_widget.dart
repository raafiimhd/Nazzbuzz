import 'package:flutter/material.dart';

class Pageviewwidget extends StatelessWidget {
  const Pageviewwidget({super.key, required this.image, required this.text});
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SizedBox(
            height: 300,
            child: Image.asset(
              image,
            ),
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        const Text(
          'Balances your emotions and make'
          ' \nyou to feel happy',
          style: TextStyle(color: Colors.white, fontSize: 19),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
