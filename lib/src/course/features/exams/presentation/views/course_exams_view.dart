import 'package:tunceducationn/core/common/views/loading_view.dart';
import 'package:tunceducationn/core/common/widgets/nested_back_button.dart';
import 'package:tunceducationn/core/common/widgets/not_found_text.dart';
import 'package:tunceducationn/core/extensions/context_extension.dart';
import 'package:tunceducationn/core/extensions/int_extensions.dart';
import 'package:tunceducationn/core/utils/core_utils.dart';
import 'package:tunceducationn/src/course/domain/entities/course.dart';
import 'package:tunceducationn/src/course/features/exams/presentation/app/cubit/exam_cubit.dart';
import 'package:tunceducationn/src/course/features/exams/presentation/views/exam_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseExamsView extends StatefulWidget {
  const CourseExamsView(this.course, {super.key});

  static const routeName = '/course-exams';

  final Course course;

  @override
  State<CourseExamsView> createState() => _CourseExamsViewState();
}

class _CourseExamsViewState extends State<CourseExamsView> {
  void getExams() {
    context.read<ExamCubit>().getExams(widget.course.id);
  }

  @override
  void initState() {
    super.initState();
    getExams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('${widget.course.title} Exams'),
        leading: NestedBackButton(),
      ),
      body: BlocConsumer<ExamCubit, ExamState>(
        listener: (_, state) {
          if (state is ExamError) {
            CoreUtils.showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is GettingExams) {
            return LoadingView();
          } else if ((state is ExamsLoaded && state.exams.isEmpty) ||
              state is ExamError) {
            return NotFoundText(
              textAlign: TextAlign.center,
              fontSize: 16.sp,
              text: 'No exams found for ${widget.course.title}',
            );
          } else if (state is ExamsLoaded) {
            return SafeArea(
              child: ListView.builder(
                itemCount: state.exams.length,
                padding: EdgeInsets.all(20),
                itemBuilder: (_, index) {
                  final exam = state.exams[index];
                  return Stack(
                    children: [
                      Card(
                        margin: EdgeInsets.all(4).copyWith(bottom: 30),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exam.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(exam.description),
                              SizedBox(height: 10.h),
                              Text(
                                exam.timeLimit.displayDuration,
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.width * .2,
                            vertical: 10.h,
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                ExamDetailsView.routeName,
                                arguments: exam,
                              );
                            },
                            child: Text('Take Exam'),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}
