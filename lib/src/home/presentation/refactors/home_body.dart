import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tunceducationn/core/common/app/providers/course_of_the_day_notifier.dart';
import 'package:tunceducationn/core/common/views/loading_view.dart';
import 'package:tunceducationn/core/common/widgets/not_found_text.dart';
import 'package:tunceducationn/core/utils/core_utils.dart';
import 'package:tunceducationn/src/course/presentation/cubit/course_cubit.dart';
import 'package:tunceducationn/src/home/presentation/refactors/home_header.dart';
import 'package:tunceducationn/src/home/presentation/refactors/home_subjects.dart';
import 'package:tunceducationn/src/home/presentation/refactors/home_videos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  void getCourses() {
    context.read<CourseCubit>().getCourses();
  }

  @override
  void initState() {
    super.initState();
    getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseCubit, CourseState>(
      listener: (_, state) {
        if (state is CourseError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is CoursesLoaded && state.courses.isNotEmpty) {
          final courses = state.courses..shuffle();
          final courseOfTheDay = courses.first;
          context
              .read<CourseOfTheDayNotifier>()
              .setCourseOfTheDay(courseOfTheDay);
        }
      },
      builder: (context, state) {
        if (state is LoadingCourses) {
          return const LoadingView();
        } else if ((state is CoursesLoaded && state.courses.isEmpty) ||
            state is CourseError) {
          return NotFoundText(
            text: 'No courses found\nPlease contact admin or if you are admin, '
                'add courses',
            textAlign: TextAlign.center,
            fontSize: 16.sp,
          );
        } else if (state is CoursesLoaded) {
          final courses = state.courses
            ..sort(
              (a, b) => b.updatedAt.compareTo(a.updatedAt),
            );
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            children: [
              const HomeHeader(),
              SizedBox(height: 20.h),
              HomeSubjects(courses: courses),
              SizedBox(height: 20.h),
              const HomeVideos(),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
