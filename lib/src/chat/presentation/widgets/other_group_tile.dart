import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tunceducationn/core/extensions/context_extension.dart';
import 'package:tunceducationn/core/res/res.dart';
import 'package:tunceducationn/src/chat/domain/entities/group.dart';
import 'package:tunceducationn/src/chat/presentation/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtherGroupTile extends StatelessWidget {
  const OtherGroupTile(this.group, {super.key});

  final Group group;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(group.name, style: TextStyle(fontSize: 16.sp)),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(360.r),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 24.r,
          child: Image.network(group.groupImageUrl!),
        ),
      ),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colours.primaryColour,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        ),
        onPressed: () {
          context.read<ChatCubit>().joinGroup(
                groupId: group.id,
                userId: context.currentUser!.uid,
              );
        },
        child: Text('Join', style: TextStyle(fontSize: 14.sp)),
      ),
    );
  }
}
