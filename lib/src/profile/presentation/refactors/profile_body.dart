// ignore_for_file: public_member_api_docs, sort_ructors_first, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import 'package:tunceducationn/core/common/app/providers/user_provider.dart';
import 'package:tunceducationn/core/core.dart';
import 'package:tunceducationn/core/extensions/context_extension.dart';
import 'package:tunceducationn/core/services/injection_container.dart';
import 'package:tunceducationn/src/auth/presentation/views/sign_in_screen.dart';
import 'package:tunceducationn/src/course/features/exams/presentation/views/add_exam_view.dart';
import 'package:tunceducationn/src/course/features/materials/presentation/views/add_materials_view.dart';
import 'package:tunceducationn/src/course/features/videos/presentation/view/add_video_view.dart';
import 'package:tunceducationn/src/course/presentation/cubit/course_cubit.dart';
import 'package:tunceducationn/src/course/presentation/widgets/add_course_sheet.dart';
import 'package:tunceducationn/src/profile/presentation/widgets/admin_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        final user = value.user;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: UserInfoCard(
                      infoThemeColor: Colors.white,
                      infoIcon: Icon(
                        Icons.pages,
                        size: 24.w,
                        color: Colors.black,
                      ),
                      infoTitle: "Courses",
                      infoValue: user!.enrolledCourseIds.length.toString()),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                  child: UserInfoCard(
                      infoThemeColor: Colors.white,
                      infoIcon: Image.asset(
                        MediaRes.scoreboard,
                        height: 24.h,
                        width: 24.w,
                      ),
                      infoTitle: "Score",
                      infoValue: user.points.toString()),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Expanded(
                  child: UserInfoCard(
                      infoThemeColor: Colors.white,
                      infoIcon: Icon(
                        Icons.person,
                        size: 24.w,
                      ),
                      infoTitle: "Following",
                      infoValue: user.following.length.toString()),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                  child: UserInfoCard(
                      infoThemeColor: Colors.white,
                      infoIcon: Icon(
                        Icons.person_outline_outlined,
                        color: Colors.red[900]!,
                      ),
                      infoTitle: "Followers",
                      infoValue: user.followers.length.toString()),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            if (context.currentUser!.isAdmin) ...[
              AdminButton(
                label: 'Add Course',
                icon: IconlyLight.paper_upload,
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: Colors.white,
                    isScrollControlled: true,
                    showDragHandle: true,
                    elevation: 0,
                    useSafeArea: true,
                    builder: (_) => BlocProvider(
                      create: (_) => s1<CourseCubit>(),
                      child: AddCourseSheet(),
                    ),
                  );
                },
              ),
              AdminButton(
                label: "Add Video",
                icon: IconlyBold.video,
                onPressed: () {
                  Navigator.of(context).pushNamed(AddVideoView.routeName);
                },
              ),
              AdminButton(
                label: "Add Material",
                icon: IconlyBold.document,
                onPressed: () {
                  Navigator.of(context).pushNamed(AddMaterialView.routeName);
                },
              ),
              AdminButton(
                  label: "Add Exams",
                  icon: IconlyLight.document,
                  onPressed: () {
                    Navigator.of(context).pushNamed(AddExamView.routeName);
                  })
            ],
            AdminButton(
                label: "Delete Account",
                icon: IconlyBold.delete,
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text("Do you want to delete the account?"),
                      titleTextStyle:
                          TextStyle(fontSize: 24.sp, color: Colors.red[900]!),
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "No",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () async {
                            await FirebaseAuth.instance.currentUser!.delete();
                            Navigator.of(context)
                                .pushReplacementNamed(SignInScreen.routeName);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Account Has been Deleted"),
                              ),
                            );
                          },
                          child: Text(
                            "Yes",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        );
      },
    );
  }
}

class UserInfoCard extends StatelessWidget {
  final Color infoThemeColor;
  final Widget infoIcon;
  final String infoTitle;
  final String infoValue;
  const UserInfoCard({
    super.key,
    required this.infoThemeColor,
    required this.infoIcon,
    required this.infoTitle,
    required this.infoValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84.h,
      width: 156.w,
      decoration: BoxDecoration(
        border: Border.all(
          color: infoThemeColor,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: infoThemeColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: infoIcon,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  infoTitle,
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.red[900],
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  infoValue,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
