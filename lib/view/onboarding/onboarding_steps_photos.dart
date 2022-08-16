import 'package:flutter/material.dart';

import '/util/styles.dart';

class OnboardingStepPhotos extends StatelessWidget {
  const OnboardingStepPhotos(
      {Key? key,
      required this.titleText,
      required this.contentText,
      required this.imagePath})
      : super(key: key);
  final String titleText;
  final String contentText;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image(
                image: AssetImage(imagePath),
                height: 280.0,
                width: 280.0,
              ),
            ),
            const SizedBox(height: 30.0),
            Text(
              titleText,
              style: kTitleStyle,
            ),
            const SizedBox(height: 15.0),
            Text(
              contentText,
              style: kSubtitleStyle,
            ),
          ],
        ),
      ),
    );
  }
}
