import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunceducationn/core/extensions/context_extension.dart';
import 'package:tunceducationn/core/res/res.dart';
import 'package:tunceducationn/src/on_boarding/domain/entities/entities.dart';
import 'package:tunceducationn/src/on_boarding/presentation/cubit/on_boarding/on_boarding_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({required this.pageContent, super.key});

  final PageContent pageContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(pageContent.image, height: context.height * .4),
        SizedBox(height: context.height * .03),
        Padding(
          padding: EdgeInsets.all(20.w).copyWith(bottom: 0),
          child: Column(
            children: [
              Text(
                pageContent.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: Fonts.aeonik,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: context.height * .02),
              Text(
                pageContent.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: Colors.white),
              ),
              SizedBox(height: context.height * .05),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 50.w,
                    vertical: 17.h,
                  ),
                  backgroundColor: Colours.primaryColour,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  context.read<OnBoardingCubit>().cacheFirstTimer();
                },
                child: Text(
                  'Get Started',
                  style: TextStyle(
                      fontFamily: Fonts.aeonik,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
