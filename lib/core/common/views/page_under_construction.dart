import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tunceducationn/core/res/res.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Under Construction"),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(MediaRes.onBoardingBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(child: Lottie.asset(MediaRes.pageUnderConstruction)),
        ),
      ),
    );
  }
}
