import 'package:flutter/material.dart';

class DisplayEmpty extends StatelessWidget {
  final VoidCallback onButtonPress;
  final String message;
  final String image;
  const DisplayEmpty(
      {super.key,
      required this.onButtonPress,
      required this.message,
      required this.image});

  @override
  Widget build(BuildContext context) {
    const TextStyle boldStyle = TextStyle(fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Image.asset(
              image,
              width: 200,
              height: 200,
              fit: BoxFit.contain, // Choose a fit mode that suits your needs
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Text(message, textAlign: TextAlign.center, style: boldStyle),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: onButtonPress,
                  child: const Text(
                    'Refresh Screen',
                    style: boldStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
