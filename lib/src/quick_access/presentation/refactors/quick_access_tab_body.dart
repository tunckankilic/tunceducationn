import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tunceducationn/core/common/views/loading_view.dart';
import 'package:tunceducationn/core/common/widgets/not_found_text.dart';
import 'package:tunceducationn/core/services/injection_container.dart';
import 'package:tunceducationn/core/utils/core_utils.dart';
import 'package:tunceducationn/src/course/features/exams/presentation/app/cubit/exam_cubit.dart';
import 'package:tunceducationn/src/course/presentation/cubit/course_cubit.dart';
import 'package:tunceducationn/src/quick_access/presentation/providers/quick_access_tab_controller.dart';
import 'package:tunceducationn/src/quick_access/presentation/refactors/document_and_exam_body.dart';
import 'package:tunceducationn/src/quick_access/presentation/refactors/exam_history_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class QuickAccessTabBody extends StatefulWidget {
  const QuickAccessTabBody({super.key});

  @override
  State<QuickAccessTabBody> createState() => _QuickAccessTabBodyState();
}

class _QuickAccessTabBodyState extends State<QuickAccessTabBody> {
  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>().getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseCubit, CourseState>(
      listener: (_, state) {
        if (state is CourseError) {
          CoreUtils.showSnackBar(context, state.message);
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
          return Consumer<QuickAccessTabController>(
            builder: (_, controller, __) {
              switch (controller.currentIndex) {
                case 0:
                case 1:
                  return DocumentAndExamBody(
                    courses: courses,
                    index: controller.currentIndex,
                  );
                default:
                  return BlocProvider(
                    create: (_) => s1<ExamCubit>(),
                    child: const ExamHistoryBody(),
                  );
              }
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
