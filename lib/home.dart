import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Timer _timer;
  int baseTime = 120;
  // final player = AudioCache(prefix: 'assets/sounds/');
  final player = AudioPlayer();
  late double screenWidth;
  late double screenHeight;

  String get timerString {
    Duration? duration =
        _animationController.duration! * _animationController.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void setController(int time) {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: time),
    );
  }

  void startEverything(int time) {
    setController(time);
    _timer = Timer(Duration(seconds: time), () {
      player.play(AssetSource('sounds/clock.wav'));
    });
    _animationController.reverse(
        from: _animationController.value == 0.0
            ? 1.0
            : _animationController.value);
  }

  @override
  void initState() {
    super.initState();
    setController(baseTime);
    startEverything(baseTime);
  }

  void cancelTimer() {
    _timer.cancel();
  }

  @override
  void dispose() {
    cancelTimer();
    player.dispose();
    super.dispose();
  }

  void controlEverything(int time) {
    if (_animationController.isAnimating) {
      _animationController.stop();
      _animationController.reset();
      cancelTimer();
    } else {
      startEverything(time);
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          buildCountdown2(),
        ],
      ),
    );
  }

  Center buildCountdown2() {
    return Center(
      child: AnimatedBuilder(
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: [
              SizedBox(
                width: screenWidth,
                height: screenHeight,
                child: Image.asset(
                  'assets/img.png',
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: _animationController.value * screenHeight,
                  child: Image.asset(
                    'assets/teaBack.png',
                    fit: BoxFit.cover,
                    width: screenWidth,
                    height: screenHeight,
                  ),
                ),
              ),
              Center(
                child: Text(
                  timerString,
                  style: const TextStyle(
                    fontSize: 100,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
        animation: _animationController,
      ),
    );
  }
}
