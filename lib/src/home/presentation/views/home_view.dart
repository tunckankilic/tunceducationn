import 'package:flutter/material.dart';
import 'package:tunceducationn/core/common/widgets/gradient_background.dart';
import 'package:tunceducationn/core/core.dart';
import 'package:tunceducationn/src/home/presentation/widgets/home_app_bar.dart';

import '../refactors/home_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: HomeAppBar(),
      body: GradientBackground(
        image: MediaRes.homeGradientBackground,
        child: HomeBody(),
      ),
    );
  }
}
