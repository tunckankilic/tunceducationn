// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:tunceducationn/core/common/widgets/gradient_background.dart';
import 'package:tunceducationn/core/core.dart';
import 'package:tunceducationn/core/enums/notification_enum.dart';
import 'package:tunceducationn/core/services/injection_container.dart';
import 'package:tunceducationn/src/notifications/data/models/notification_model.dart';
import 'package:tunceducationn/src/notifications/presentation/cubit/notification_cubit.dart';
import 'package:tunceducationn/src/profile/presentation/refactors/profile_body.dart';
import 'package:tunceducationn/src/profile/presentation/refactors/profile_header.dart';
import 'package:tunceducationn/src/profile/presentation/widgets/profile_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: const ProfileAppBar(),
      body: GradientBackground(
        image: MediaRes.profileGradientBackground,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: const [
            ProfileHeader(),
            ProfileBody(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[900],
        onPressed: () {
          s1<NotificationCubit>().sendNotification(
            NotificationModel.empty().copyWith(
              title: 'Test Notification',
              body: 'body',
              category: NotificationCategory.NONE,
            ),
          );
        },
        child: const Icon(IconlyLight.notification),
      ),
    );
  }
}
