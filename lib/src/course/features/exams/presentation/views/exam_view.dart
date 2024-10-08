import 'package:tunceducationn/core/res/res.dart';
import 'package:tunceducationn/core/utils/core_utils.dart';
import 'package:tunceducationn/src/course/features/exams/presentation/app/cubit/exam_cubit.dart';
import 'package:tunceducationn/src/course/features/exams/presentation/app/providers/exam_controller.dart';
import 'package:tunceducationn/src/course/features/exams/presentation/widgets/exam_navigation_blob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamView extends StatefulWidget {
  const ExamView({super.key});

  static const routeName = '/exam';

  @override
  State<ExamView> createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {
  bool showingLoader = false;

  late ExamController examController;

  Future<void> submitExam() async {
    if (!examController.isTimeUp) {
      examController.stopTimer();
      final isMinutesLeft = examController.remainingTimeInSeconds > 60;
      final isHoursLeft = examController.remainingTimeInSeconds > 3600;
      final timeLeftText = isHoursLeft
          ? 'hours'
          : isMinutesLeft
              ? 'minutes'
              : 'seconds';

      final endExam = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: Text('Submit Exam?'),
            content: Text(
              'You have ${examController.remainingTime} $timeLeftText left.\n'
              'Are you sure you want to submit?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colours.redColour),
                ),
              ),
            ],
          );
        },
      );
      if (endExam ?? false) {
        return collectAndSend();
      } else {
        examController.startTimer();
        return;
      }
    }
    collectAndSend();
  }

  void collectAndSend() {
    final exam = examController.userExam;
    context.read<ExamCubit>().submitExam(exam);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    examController = context.read<ExamController>();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      examController.addListener(() {
        if (examController.isTimeUp) submitExam();
      });
    });
  }

  @override
  void dispose() {
    examController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExamController>(
      builder: (_, controller, __) {
        return BlocConsumer<ExamCubit, ExamState>(
          listener: (_, state) {
            if (showingLoader) {
              Navigator.pop(context);
              showingLoader = false;
            }
            if (state is ExamError) {
              CoreUtils.showSnackBar(context, state.message);
            } else if (state is SubmittingExam) {
              CoreUtils.showLoadingDialog(context);
              showingLoader = true;
            } else if (state is ExamSubmitted) {
              CoreUtils.showSnackBar(context, 'Exam Submitted');
              Navigator.pop(context);
            }
          },
          builder: (_, state) => WillPopScope(
            onWillPop: () async {
              if (state is SubmittingExam) return false;
              if (controller.isTimeUp) return true;
              final result = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog.adaptive(
                    title: Text('Exit Exam'),
                    content: Text('Are you sure you want to Exit the exam'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Text('Exit exam'),
                      ),
                    ],
                  );
                },
              );
              return result ?? false;
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                centerTitle: true,
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(MediaRes.examTimeRed,
                        height: 30.h, width: 30.w),
                    SizedBox(width: 10.w),
                    Text(
                      controller.remainingTime,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colours.redColour,
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: submitExam,
                    child: Text('Submit', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Text(
                              'Question ${controller.currentIndex + 1}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color(0xFF666E7A),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: Color(0xFFC4C4C4),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Center(
                                child: controller.exam.imageUrl == null
                                    ? Image.asset(
                                        MediaRes.test,
                                        height: 200.h,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        controller.exam.imageUrl!,
                                        height: 200.h,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              controller.currentQuestion.questionText,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  controller.currentQuestion.choices.length,
                              itemBuilder: (_, index) {
                                final choice =
                                    controller.currentQuestion.choices[index];
                                return RadioListTile(
                                  value: choice.identifier,
                                  contentPadding: EdgeInsets.zero,
                                  groupValue: controller.userAnswer?.userChoice,
                                  title: Text(
                                    '${choice.identifier}. '
                                    '${choice.choiceAnswer}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    controller.answer(choice);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      ExamNavigationBlob(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
