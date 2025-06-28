import 'dart:convert';
import 'dart:io';

import 'package:tunceducationn/core/common/widgets/course_picker.dart';
import 'package:tunceducationn/core/enums/notification_enum.dart';
import 'package:tunceducationn/core/res/media_res.dart';
import 'package:tunceducationn/core/utils/core_utils.dart';
import 'package:tunceducationn/core/utils/typedefs.dart';
import 'package:tunceducationn/src/course/domain/entities/course.dart';
import 'package:tunceducationn/src/course/features/exams/data/models/exam_model.dart';
import 'package:tunceducationn/src/course/features/exams/presentation/app/cubit/exam_cubit.dart';
import 'package:tunceducationn/src/notifications/presentation/presentation/widgets/notification_wrapper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddExamView extends StatefulWidget {
  const AddExamView({super.key});

  static const routeName = '/add-exam';

  @override
  State<AddExamView> createState() => _AddExamViewState();
}

class _AddExamViewState extends State<AddExamView> {
  File? examFile;

  final formKey = GlobalKey<FormState>();
  final courseController = TextEditingController();
  final courseNotifier = ValueNotifier<Course?>(null);

  Future<void> pickExamFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    if (result != null) {
      setState(() {
        examFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> uploadExam() async {
    if (examFile == null) {
      return CoreUtils.showSnackBar(context, 'Please pick an exam to upload');
    }
    if (formKey.currentState!.validate()) {
      final json = examFile!.readAsStringSync();
      final jsonMap = jsonDecode(json) as DataMap;
      final exam = ExamModel.fromUploadMap(jsonMap)
          .copyWith(courseId: courseNotifier.value!.id);
      await context.read<ExamCubit>().uploadExam(exam);
    }
  }

  bool showingDialog = false;

  @override
  void dispose() {
    courseController.dispose();
    courseNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationWrapper(
      onNotificationSent: () {
        Navigator.of(context).pop();
      },
      child: BlocListener<ExamCubit, ExamState>(
        listener: (_, state) {
          if (showingDialog == true) {
            Navigator.pop(context);
            showingDialog = false;
          }
          if (state is UploadingExam) {
            CoreUtils.showLoadingDialog(context);
            showingDialog = true;
          } else if (state is ExamError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is ExamUploaded) {
            CoreUtils.showSnackBar(context, 'Exam uploaded successfully');
            CoreUtils.sendNotification(
              context,
              title: 'New ${courseNotifier.value!.title} exam',
              body: 'A new exam has been added for '
                  '${courseNotifier.value!.title}',
              category: NotificationCategory.TEST,
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: Text('Add Exam')),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: CoursePicker(
                        controller: courseController,
                        notifier: courseNotifier,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    if (examFile != null) ...[
                      SizedBox(height: 10.h),
                      Card(
                        child: ListTile(
                          leading: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Image.asset(MediaRes.json),
                          ),
                          title: Text(examFile!.path.split('/').last),
                          trailing: IconButton(
                            onPressed: () => setState(() {
                              examFile = null;
                            }),
                            icon: Icon(Icons.close),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                    ],
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: pickExamFile,
                          child: Text(
                            examFile == null
                                ? 'Select Exam File'
                                : 'Replace Exam File',
                          ),
                        ),
                        SizedBox(width: 10.w),
                        ElevatedButton(
                          onPressed: uploadExam,
                          child: Text('Confirm'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
