import 'package:tunceducationn/core/common/widgets/course_info_tile.dart';
import 'package:tunceducationn/core/common/widgets/gradient_background.dart';
import 'package:tunceducationn/core/common/widgets/rounded_button.dart';
import 'package:tunceducationn/core/extensions/context_extension.dart';
import 'package:tunceducationn/core/extensions/int_extensions.dart';
import 'package:tunceducationn/core/res/res.dart';
import 'package:tunceducationn/core/utils/core_utils.dart';
import 'package:tunceducationn/src/course/features/exams/data/models/exam_model.dart';
import 'package:tunceducationn/src/course/features/exams/domain/entities/exam.dart';
import 'package:tunceducationn/src/course/features/exams/presentation/app/cubit/exam_cubit.dart';
import 'package:tunceducationn/src/course/features/exams/presentation/views/exam_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamDetailsView extends StatefulWidget {
  const ExamDetailsView(this.exam, {super.key});

  static const routeName = '/exam-details';

  final Exam exam;

  @override
  State<ExamDetailsView> createState() => _ExamDetailsViewState();
}

class _ExamDetailsViewState extends State<ExamDetailsView> {
  late Exam completeExam;

  void getQuestions() {
    context.read<ExamCubit>().getExamQuestions(widget.exam);
  }

  @override
  void initState() {
    completeExam = widget.exam;
    super.initState();
    getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text(widget.exam.title)),
      body: GradientBackground(
        image: MediaRes.documentsGradientBackground,
        child: BlocConsumer<ExamCubit, ExamState>(
          listener: (_, state) {
            if (state is ExamError) {
              CoreUtils.showSnackBar(context, state.message);
            } else if (state is ExamQuestionsLoaded) {
              completeExam = (completeExam as ExamModel).copyWith(
                questions: state.questions,
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Center(
                            child: Container(
                              width: 80.w,
                              height: 80.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colours.physicsTileColour,
                              ),
                              child: Center(
                                child: completeExam.imageUrl != null
                                    ? Image.network(
                                        completeExam.imageUrl!,
                                        width: 60.w,
                                        height: 60.h,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        MediaRes.test,
                                        width: 60.w,
                                        height: 60.h,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            completeExam.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            completeExam.description,
                            style: TextStyle(
                              color: Colours.neutralTextColour,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          CourseInfoTile(
                            image: MediaRes.examTime,
                            title:
                                '${completeExam.timeLimit.displayDurationLong}'
                                ' for the test.',
                            subtitle: 'Complete the test in '
                                '${completeExam.timeLimit.displayDurationLong}',
                          ),
                          if (state is ExamQuestionsLoaded) ...[
                            SizedBox(height: 10.h),
                            CourseInfoTile(
                              image: MediaRes.examQuestions,
                              title: '${completeExam.questions?.length} '
                                  'Questions',
                              subtitle: 'This test consists of '
                                  '${completeExam.questions?.length} questions',
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (state is GettingExamQuestions)
                      Center(child: LinearProgressIndicator())
                    else if (state is ExamQuestionsLoaded)
                      RoundedButton(
                        label: 'Start Exam',
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            ExamView.routeName,
                            arguments: completeExam,
                          );
                        },
                      )
                    else
                      Text(
                        'No Questions for this exam',
                        style: context.theme.textTheme.titleLarge,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
