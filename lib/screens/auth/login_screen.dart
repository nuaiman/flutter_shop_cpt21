import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RotatedBox(
            quarterTurns: 2,
            child: WaveWidget(
              config: CustomConfig(
                colors: [
                  Colors.orangeAccent,
                  Colors.tealAccent,
                  Colors.pinkAccent,
                  Colors.deepPurpleAccent,
                ],
                durations: [35000, 11000, 10800, 6000],
                heightPercentages: [0.01, 0.02, 0.03, 0.1],
                blur: const MaskFilter.blur(BlurStyle.solid, 0),
              ),
              heightPercentange: 0.2,
              size: const Size(double.infinity, double.infinity),
            ),
          ),
        ],
      ),
    );
  }
}
