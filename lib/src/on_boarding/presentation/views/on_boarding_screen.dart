import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tunceducationn/core/common/views/loading_view.dart';
import 'package:tunceducationn/core/common/widgets/gradient_background.dart';
import 'package:tunceducationn/core/core.dart';
import 'package:tunceducationn/src/on_boarding/domain/domain.dart';
import 'package:tunceducationn/src/on_boarding/presentation/cubit/on_boarding/on_boarding_cubit.dart';
import 'package:tunceducationn/src/on_boarding/presentation/widgets/on_boarding_body.dart';

// A StatefulWidget representing the OnBoarding screen.
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const routeName = '/';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final pageController = PageController();

  @override
  void initState() {
    super.initState();
    // When the screen initializes, trigger the checkIfUserIsFirstTimer method from the OnBoardingCubit.
    context.read<OnBoardingCubit>().checkIfUserIsFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GradientBackground(
        image: MediaRes.onBoardingBackground,
        child: BlocConsumer<OnBoardingCubit, OnBoardingState>(
          listener: (context, state) {
            // Listen to changes in the OnBoardingCubit's state and take action accordingly.
            if (state is OnBoardingStatus && !state.isFirstTimer) {
              Navigator.of(context).pushReplacementNamed("/home");
            } else if (state is UserCached) {
              Navigator.of(context)
                  .pushReplacementNamed(OnBoardingScreen.routeName);
            }
          },
          builder: (context, state) {
            if (state is CheckingIfUserIsFirstTimer ||
                state is CachingFirstTimer) {
              // While checking or caching, display a loading view.
              return const LoadingView();
            }
            return Stack(
              children: [
                PageView(
                  controller: pageController,
                  children: const [
                    OnBoardingBody(pageContent: PageContent.first()),
                    OnBoardingBody(pageContent: PageContent.second()),
                    OnBoardingBody(pageContent: PageContent.third()),
                  ],
                ),
                Align(
                  alignment: const Alignment(0, .04),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    onDotClicked: (index) {
                      pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    effect: const WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 40,
                      activeDotColor: Colours.primaryColour,
                      dotColor: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
