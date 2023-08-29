import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/constant/app_images.dart';
import 'package:todo/utils/widgets/common_widgets.dart';
import 'package:vibration/vibration.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AudioPlayer().play(AssetSource('audio/Success.mp3'));
    Vibration.vibrate(duration: 500);
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(
          0.85), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
      body: Center(
        child: SizedBox(
          height: fullHeight(context) * 0.32,
          width: fullWidth(context) * 0.70,
          child: Lottie.asset(AppImages.successLottie,
              fit: BoxFit.fill,
              controller: _controller, onLoaded: (composition) {
            // Configure the AnimationController with the duration of the
            // Lottie file and start the animation.
            _controller
              ..duration = composition.duration
              ..forward();
          }),
        ),
      ),
    );
  }
}
