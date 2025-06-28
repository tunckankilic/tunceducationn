import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tunceducationn/core/services/injection_container.dart';
import 'package:tunceducationn/src/course/data/models/course_model.dart';
import 'package:tunceducationn/src/course/presentation/cubit/course_cubit.dart';
import 'package:tunceducationn/core/common/widgets/titled_input_field.dart';
import 'package:tunceducationn/core/utils/core_utils.dart';
import 'package:tunceducationn/core/utils/constants.dart';
import 'package:tunceducationn/core/enums/notification_enum.dart';
import 'package:tunceducationn/src/notifications/presentation/cubit/notification_cubit.dart';
import 'package:tunceducationn/src/notifications/presentation/presentation/widgets/notification_wrapper.dart';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCourseSheet extends StatefulWidget {
  const AddCourseSheet({super.key});

  @override
  State<AddCourseSheet> createState() => _AddCourseSheetState();
}

class _AddCourseSheetState extends State<AddCourseSheet> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  File? image;

  bool isFile = false;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    imageController.addListener(() {
      if (isFile && imageController.text.trim().isEmpty) {
        image = null;
        isFile = false;
      }
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<NotificationCubit>(
          create: (_) => NotificationCubit(
              clear: s1(),
              clearAll: s1(),
              getNotifications: s1(),
              markAsRead: s1(),
              sendNotification: s1()),
        ),
      ],
      child: NotificationWrapper(
        onNotificationSent: () {
          if (loading) {
            Navigator.of(context).pop();
          }
          Navigator.of(context).pop();
        },
        child: BlocListener<CourseCubit, CourseState>(
          listener: (_, state) {
            if (state is CourseError) {
              CoreUtils.showSnackBar(context, state.message);
            } else if (state is AddingCourse) {
              loading = true;
              CoreUtils.showLoadingDialog(context);
            } else if (state is CourseAdded) {
              if (loading) {
                loading = false;
                Navigator.pop(context);
              }
              CoreUtils.showSnackBar(context, 'Course added successfully');
              CoreUtils.showLoadingDialog(context);
              loading = true;
              CoreUtils.sendNotification(
                context,
                title: 'New Course(${titleController.text.trim()})',
                body: 'A new course has been added',
                category: NotificationCategory.COURSE,
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Form(
                key: formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      'Add Course',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TitledInputField(
                      controller: titleController,
                      title: 'Course Title',
                    ),
                    SizedBox(height: 20.h),
                    TitledInputField(
                      controller: descriptionController,
                      title: 'Description',
                      required: false,
                    ),
                    SizedBox(height: 20.h),
                    TitledInputField(
                      controller: imageController,
                      title: 'Course Image',
                      required: false,
                      hintText: 'Enter image URL or pick from gallery',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          final image = await CoreUtils.pickImage();
                          if (image != null) {
                            isFile = true;
                            this.image = image;
                            final imageName = image.path.split('/').last;
                            imageController.text = imageName;
                          }
                        },
                        icon: Icon(Icons.add_photo_alternate_outlined),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                final now = DateTime.now();
                                final course = CourseModel.empty().copyWith(
                                  title: titleController.text.trim(),
                                  description:
                                      descriptionController.text.trim(),
                                  image: imageController.text.trim().isEmpty
                                      ? kDefaultAvatar
                                      : isFile
                                          ? image!.path
                                          : imageController.text.trim(),
                                  createdAt: now,
                                  updatedAt: now,
                                  imageIsFile: isFile,
                                );
                                context.read<CourseCubit>().addCourse(course);
                              }
                            },
                            child: Text('Add'),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel'),
                          ),
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
